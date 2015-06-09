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


# muestra el listado de lineas
get '/articulos/:id' do
  @articulos = DB[:articulos]
  erb :cons_linea
end
 


 # muestra los detalles del producto
get '/articulosaaaa/:id' do
	@articulo = DB[:articulos]['']

  #@articulos = Articulo.get(params[:id])
  if @articulo
     erb :cons_linea
  else
      redirect '/articulos'
  end
end