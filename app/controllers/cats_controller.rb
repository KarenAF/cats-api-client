class CatsController < ApplicationController
  def index
    @cats = Unirest.get("http://localhost:3000/v1/cats.json").body
    render 'index.html.erb'
  end

  def show
    @cat = Unirest.get("http://localhost:3000/v1/cats/#{params[:id]}.json").body
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @cat = Unirest.post(
      "http://localhost:3000/v1/cats.json",
      headers: {"Accept" => "application/json" },
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
    @cat = Unirest.get("http://localhost:3000/v1/cats/#{params[:id]}.json").body
    render 'edit.html.erb'
  end

  def update
    @cat = Unirest.patch(
      "http://localhost:3000/v1/cats/#{params['id']}.json",
      headers: {"Accept" => "application/json" },
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
    @cat = Unirest.delete("http://localhost:3000/v1/cats/#{params[:id]}.json").body
    redirect_to '/cats'
  end
end