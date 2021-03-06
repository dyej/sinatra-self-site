require 'sinatra'
require 'sinatra/content_for'
require 'yaml'

require './lib/helper_utils'

@@general_data = YAML.load_file('data/general.yml')
@@paragraph_data = YAML.load_file('data/paragraphs.yml')
@@num_uploads = 5

configure do
  set :environment, "production"
end

helpers HelperUtils

get '/' do 
  erb :index, :locals => {:onIndex => true}
end

get '/utils/pdf' do
  erb :pdf
end 

post '/utils/pdf/combine' do
  if params[:commit] == '+'
    @@num_uploads += 1
    redirect to('/utils/pdf')
  elsif params[:commit] == 'Submit'
    pdf_combine params
    send_file "public/uploads/merged.pdf"
  end
end

not_found do
  'This location does not exist.'
end
