require 'sinatra'
require 'data_mapper'
require 'slim'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.rb")

class Task
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String, :required => true
  property :completed_at, DateTime
end
DataMapper.finalize

get '/' do
  @tasks = Task.all
  slim :index
end

get '/:task' do
  @task = params[:task].split('-').join(' ').capitalize
  slim :task
end

post '/' do
  Task.create name: params[:task]
  redirect '/'
end
