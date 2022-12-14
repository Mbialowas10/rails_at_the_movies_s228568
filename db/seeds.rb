require "csv"

#Movie.delete_all
#ProductionCompany.delete_all

Page.delete_all
MovieGenre.delete_all
Genre.delete_all
Movie.delete_all




Page.create(
  title: 'About the data',
  content: 'The data powering this awesome website was taken from Kaggle.',
  permalink: 'about_the_data'

)
Page.create(
  title: 'Contact us',
  content: 'Read out to me if you want to discuss coding, or just life :)',
  permalink: 'contact'

)

filename = Rails.root.join("db/top_movies.csv")
puts "Loading Movies from the csv file: #{filename}"

csv_data = File.read(filename)
movies = CSV.parse(csv_data, headers:true, encoding: "utf-8")

movies.each do  | m |
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])
  if production_company && production_company.valid?
    #create a movie
    movie = production_company.movies.create(
      title:        m["original_title"],
      year:         m["year"],
      duration:     m["duration"],
      description:  m["description"],
      average_vote: m["avg_vote"]
    )
    puts "Invalid Movie #{m['original_title']}" unless movie&.valid?

    #genres
    genres = m["genre"].split(",").map(&:strip)

    genres.each do |genre_name|
      genre = Genre.find_or_create_by(name: genre_name)

      MovieGenre.create(movie: movie, genre: genre)
    end
  else
    puts "invalid production company #{m["production_company"]} for movie #{m['original_title']}"
  end
  #puts m['original_title']
end
puts "Created #{ProductionCompany.count} Production Companies"
puts "Created #{Movie.count} movies."
puts "Created #{Genre.count} Genres"
puts "Created #{MovieGenre.count} MovieGenres"


