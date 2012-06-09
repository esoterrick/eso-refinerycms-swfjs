Refinery::Core::Engine.routes.append do
  match '/system/swfs/*dragonfly', :to => Dragonfly[:refinery_swfs]

  # Frontend routes
  namespace :swfs do
    resources :swfs, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :swfs, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :swfs do
        post :append_to_wym
        collection do
          post :update_positions
          get :insert
          get :dialog_preview
        end
      end
      resources :swf_files, :only => [:destroy]
    end
  end

end
