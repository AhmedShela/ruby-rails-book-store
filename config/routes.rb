Rails.application.routes.draw do
  devise_for :authors
  root to: "books#index"
  get '/books', to: 'books#index'
  get '/books/new', to: 'books#new', as: 'new_book'
  post '/books', to: 'books#create'
  get '/books/:id', to: 'books#show', as: 'book'
  get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  patch '/books/:id', to: 'books#update'
  delete '/books/:id', to: 'books#destroy'
  
  get '/authors', to: 'authors#index'
  get '/authors/new', to: 'authors#new', as: 'new_author'
  post '/authors', to: 'authors#create'
  get '/authors/:id', to: 'authors#show', as: 'author'
  get '/authors/:id/edit', to: 'authors#edit', as: 'edit_author'
  patch '/authors/:id', to: 'authors#update'
  delete '/authors/:id', to: 'authors#destroy'
  
end