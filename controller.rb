require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/screening.rb')
require_relative('./models/ticket.rb')

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

get '/films/3' do
    @films = Film.all()
    erb(:film3)
end

get '/films/4' do
    @films = Film.all()
    erb(:film4)
end
