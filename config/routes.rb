Rails.application.routes.draw do
    get '/' => 'users#index'
    post '/create' => 'users#create'
    post '/login' => 'users#login'
    get '/show' => 'users#show'
    post '/posts/update/:id'=> 'users#update'
    get '/posts/:id' => 'users#post'
    post '/posts/like/:id' =>'users#like'
    post '/posts/unlike/:id' => 'users#unlike'
    get '/info/:id' =>'users#info'
    post '/delete/:id' => 'users#delete'
    post '/logout' => 'users#logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
