
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index

  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    article = Article.create(title: params[:title], content: params[:content])

    if article.save
      redirect "articles/#{article.id}"
    else
      redirect '/articles/new'
    end
  end
  


  get '/articles/:id' do
    @articles = Article.all
    
    @article = @articles.find_by_id(params[:id])

    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find_by_id(params[:id])
    article.title = params["title"]
    article.content = params["content"]

    if article.save
      redirect "articles/#{article.id}"
    else
      redirect "/articles/#{article.id}"
    end
  end

  delete '/articles/:id' do
    article = Article.find_by_id(params[:id])
    article.destroy

    redirect '/articles'
  end

end
