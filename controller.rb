require('sinatra')
require('sinatra/contrib/all') if development?()

require_relative('./models/film.rb')
also_reload('./models/*')

get '/films' do
    @films = Film.all()
    erb(:index)
end

get '/Mulan' do
    @films = Film.all()
    erb(:film1)
end

get '/Knives Out' do
    @films = Film.all()
    erb(:film2)
end

get '/Dunkirk' do
    @films = Film.all()
    erb(:film3)
end

get '/1917' do
    @films = Film.all()
    erb(:film4)
end
