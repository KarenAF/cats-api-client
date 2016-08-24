class CatsController < ApplicationController
  HEADERS = { "Accept" => "application/json", "Authorization" => "Token token=#{ENV['API_KEY']}", "X-User-Email" => ENV['API_EMAIL'] }
  def index
    @cats = Unirest.get(
      "#{ENV['API_BASE_URL']}/cats.json",
      headers: HEADERS
      ).body
    render 'index.html.erb'
  end

  def show
    cat_hash = Unirest.get(
      "#{ENV['API_BASE_URL']}/cats/#{params[:id]}.json",
      headers: HEADERS
      ).body
    @cat = Cat.new(cat_hash)
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @cat = Unirest.post(
      "#{ENV['API_BASE_URL']}/cats.json",
      headers: HEADERS,
      parameters: {
        name: params[:form_input_name],
        breed: params[:form_input_breed],
        color: params[:form_input_color],
        age_category: params[:form_input_age_category]
      }
    ).body
    redirect_to "/cats/#{@cat['id']}"
  end

  def edit
    @cat = Unirest.get(
      "#{ENV['API_BASE_URL']}/cats/#{params[:id]}.json"
      ).body
    render 'edit.html.erb'
  end

  def update
    @cat = Unirest.patch(
      "#{ENV['API_BASE_URL']}/cats/#{params[:id]}.json",
      headers: HEADERS,
      parameters: {
        name: params[:form_input_name],
        breed: params[:form_input_breed],
        color: params[:form_input_color],
        age_category: params[:form_input_age_category]
      }
    ).body
    redirect_to "/cats/#{@cat['id']}"    
  end  

  def destroy
    message = Unirest.delete(
      "#{ENV['API_BASE_URL']}/cats/#{params[:id]}.json",
      headers: HEADERS
      ).body
    redirect_to '/cats'
  end
end