resources :notifications, only: %i[index show] do
  collection do
    post :mark_all_read
  end
end