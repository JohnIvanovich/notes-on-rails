Rails.application.routes.draw do
  scope path: '/api' do
    get :notes, to: 'notes#index'
    get 'notes/:id', to: 'notes#show'
    post :notes, to: 'notes#create'
    put :notes, to: 'notes#update'
    delete :notes, to: 'notes#destroy'
  end
end
