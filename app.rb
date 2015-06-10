# myapp.rb
require 'sinatra'
require 'pg'
require 'sequel'



DB = Sequel.connect(:adapter=>'postgres', :host=>'localhost', :database=>'expo', :port=>'5433', :user=>'postgres', :password=>'demoba')
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
  DB[:articulos].insert(marca: params[:marca],descripcion: params[:descripcion],precio: params[:precio], )
    redirect "/"
end

# muestra el listado de articulos
get '/articulos/:id' do
  @articulos = DB[:articulos]
  erb :cons_linea
end

# borra articulos
get '/borraArticulo/:id' do
  @articulos = DB[:articulos].where(:id => params[:id]).delete
  if @articulos
     redirect "/"
  else
      redirect "/"
  end
end

# edita articulos
get '/editar/:id' do
  @articulos = DB[:articulos].where(:id => params[:id])
  if @articulos
     erb :editar
  else
      redirect "/"
  end
end

# edita la producto
put '/editar/:id' do
   @articulos = DB[:articulos].where(:id => params[:id]).update(marca: params[:marca],descripcion: params[:descripcion],precio: params[:precio])
     redirect '/articulos/all'
  #end
end

 