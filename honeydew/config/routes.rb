Rails.application.routes.draw do

  resources :offers

  get 'transactions/new'

  resources :job_categories

  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users do
    resources :authentications
  end
  resources :users do
    resources :messages
  end
  resources :tasks do
    resources :job_steps, controller: 'tasks/job_steps'
    resources :todoitems
  end
  resources :todoitems
  resources :tasks
  resources :authentications
  resources :messages
  resources :reviews
  resources :tasks do
    resources :notes
  end
  resources :notes


  resources :transactions, only: [:new, :create]



  authenticated :user do
    root :to => "users#my_rio_runner", :as => :authenticated_root
  end
  root 'pages#home'
  get '/contact', :to => 'pages#contact'
  get '/playground', :to => 'pages#playground'
  get '/home2', :to => 'pages#home2'
  get '/betainformation', :to => 'pages#betainformation'
  get '/fontawesome', :to => 'pages#fontawesomeoptions'
  get '/iconinformation', :to => 'pages#iconinformation'
  get '/addcreditcardinfo', :to => 'users#add_credit_card_info'
  get '/about', :to => 'pages#about'
  get '/help', :to => 'pages#help'
  get '/signup', :to => 'users#new'
  get 'riorunner', :to => 'pages#riorunner'
  get '/users/sign_up', :to => 'devise/registrations#new'
  get '/posttask', :to => 'pages#posttask'
  get '/myriorunner', :to => 'users#my_rio_runner', as: 'myriorunner'
  get '/mymessages/:id', :to => 'messages#my_messages', as: 'mymessages'
  get '/messages/inbox/:id', :to => 'messages#rr_inbox', as: 'inbox'
  get '/messages/sent/:id', :to => 'messages#rr_sent', as: 'sent'
  get '/messages/deleted/:id', :to => 'messages#rr_deleted', as: 'deleted'
  get '/myownedjobs/:id', :to => 'tasks#my_owned_jobs', as: 'myownedjobs'
  get '/myjobs/:id', :to => 'tasks#my_jobs', as: 'myjobs'
  match 'tagged', to: 'tasks#tagged', :as => 'tagged', via: 'get'
  get 'tags/:tag', to: 'tasks#index', as: :tag
  get "tasks/tags" => "tasks#tags", :as => :tags
  get '/update_task_with_runner/:id', :to => 'tasks#update_task_with_runner', as: 'update_task_with_runner'
  get '/update_autotask_with_runner/:id', :to => 'tasks#update_autotask_with_runner', as: 'update_autotask_with_runner'
  get '/taskconfirmation/:id', :to => 'messages#taskconfirmation', as: 'taskconfirmation'
  match 'auth/:provider/callback', to: 'authentications#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  get '/markasdeleted/:id', :to => 'messages#markasdeleted', as: 'markasdeleted'
  get '/markasunread/:id', :to => 'messages#markasunread', as: 'markasunread'
  get '/markasundeleted/:id', :to => 'messages#markasundeleted', as: 'markasundeleted'
  get '/users/edit/:id', :to => 'users#edit', as: 'useredit'
  get '/addpaymentinformationtotask/:id', :to => 'users#add_payment_info', as: 'addpaymentinfo'
  get '/taskcompletion/:id', :to => 'tasks#task_completion', as: 'taskcompletion'
  get '/accept_offer/:id', :to => 'tasks#accept_offer', as: 'accept_offer'
  get '/decline_offer/:id', :to => 'tasks#decline_offer', as: 'decline_offer'
  get '/myoffers/:id', :to => 'offers#my_offers', as: 'myoffers'
  get '/taskchat/:id', :to => 'tasks#task_chat', as: 'taskchat'
  get '/mychats/:id', :to => 'messages#my_chats', as: 'mychats'
  post 'subscriptions/subscribe' => 'subscriptions#subscribe'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
