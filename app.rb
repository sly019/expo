# myapp.rb
require 'sinatra'
require 'pg'
require 'sequel'

#db_params = {
 # host: 'localhost',
  #dbname: 'expo',
  #port: '5433',
  #user: 'postgres',
  #password: '123456'
#}
#Psql = PG::Connection.new(db_params)

DB = Sequel.connect(:adapter=>'postgres', :host=>'localhost', :database=>'expo', :user=>'postgres', :password=>'123456')
# index principal
get '/' do
  erb :index
end

# nuevo producto
get '/articulos' do
  erb :nuev_linea
end

# guarda los productos
post '/articulos' do
  @articulo = DB.Articulo.new(:marca => params[:marca].upcase, :descripcion => params[:descripcion].upcase, :precio => params[:precio].upcase)
  if !campo_vacio(params[:marca]) and !campo_vacio(params[:descripcion])
     if @articulo.save
        redirect "/articulos/#{@articulo.id}"
     else
         redirect '/articulos'
     end
  else
      redirect '/index'
  end
end
 

 # muestra los detalles del producto
get '/articulos/:id' do
  @articulos = Articulo.get(params[:id])
  if @articulos
     erb :cons_linea
  else
      redirect '/articulos'
  end
end