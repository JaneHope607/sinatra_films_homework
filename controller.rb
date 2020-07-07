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

get '/films/1' do
    @films = Film.all()
    erb(:film1)
end

get '/films/2' do
    @films = Film.all()
    erb(:index)
end

get '/films/3' do
    @films = Film.all()
    erb(:index)
end

get '/films/4' do
    @films = Film.all()
    erb(:index)
end
