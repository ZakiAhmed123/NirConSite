Rails.application.routes.draw do




  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Payola::Engine => '/payola', as: :payola
  root 'basics#home'

  # BASIC NAVIGATION

  get 'contact' => 'basics#contact', as: :contact
  get 'Policies' => 'basics#policies', as: :policies
  get 'Shipping-Info' => 'basics#shipping', as: :shipping

  # PRODUCTS
  get 'products/embeds' => 'products#embeds', as: :products
  get 'products/embeds/:id' => 'products#embed_view', as: :product
  get 'products/stabilizers/:id' => 'products#stabilizer', as: :stabilizer
  get 'products/embeds/:id/pdf' => 'products#pdf', as: :pdf

  get 'products/stabilizers/:id/pdf' => 'products#stabilizer_pdf', as: :pdf_alt
  get 'products/stairs' => 'products#stairs', as: :stairs
  get 'products/stairs/:id' => 'product#stair', as: :stair

  get 'products/beams' => 'products#beams', as: :beams
  get 'products/beams/:id' => 'products#beam', as: :beam


  # ESTIMATOR
  resources :messages, only: [:new, :create]

  # ORDER HISTORY
  get 'orders' => 'orders#index', as: :orders
  get 'orders/:id' => 'orders#view', as: :order

  #SHOPPING CART
  # post 'cart' => 'carts#add_to_cart_stabilizer', as: :add_stabilizer

  post 'cart' => 'carts#add_to_cart', as: :add_to_cart
  get 'cart' => 'carts#view', as: :cart
  delete 'cart' => 'carts#remove_from_cart', as: :remove_from_cart
  delete 'cart' => 'carts#remove_from_cart_stabilizer', as: :remove_from_cart_stabilizer


  #ORDER PROCESSING I.E. CHECKOUT
  get 'checkout' =>  'checkout#start', as: :checkout
  post 'checkout' => 'checkout#process_payment', as: :process_payment
  get 'receipts/:id' => 'checkout#receipt', as: :receipt

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
