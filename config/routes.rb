Rails.application.routes.draw do

  devise_for :users
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Payola::Engine => '/payola', as: :payola
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  root 'basics#home'

  # BASIC NAVIGATION
  get 'contact' => 'basics#contact', as: :contact
  get 'Policies' => 'basics#policies', as: :policies
  get 'Shipping-Info' => 'basics#shipping_info', as: :shipping_info

  # PRODUCT LINES
  get 'products/embeds' => 'products#embeds', as: :embeds
  get 'products/embeds/:id' => 'products#embed_view', as: :embed

  get 'products/stabilizers/:id' => 'products#stabilizers_view', as: :stabilizer

  get 'products/chairs' => 'products#chairs', as: :chairs
  get 'products/chairs/:id' => 'products#chairs_view', as: :chair

  get 'products/studs' => 'products#studs', as: :studs
  get 'products/studs/:id' => 'products#studs_view', as: :stud

  get 'products/tracks/:id' => 'products#tracks_view', as: :track

  get 'products/tigerbeams' => 'products#beams', as: :beams

  # USER MAILER ESTIMATOR
  resources :contact_forms, only: [:new, :create]

  # ORDER HISTORY
  get 'orders' => 'orders#index', as: :orders
  get 'orders/:id' => 'orders#view', as: :order

  #SHOPPING CART
  post 'cart' => 'carts#add_to_cart', as: :add_to_cart
  get 'cart' => 'carts#view', as: :cart
  delete 'cart' => 'carts#remove_from_cart', as: :remove_from_cart

  #ORDER PROCESSING I.E. CHECKOUT
  get 'checkout' => 'checkout#payment', as: :checkout
  post 'checkout' => 'checkout#process_payment', as: :process_payment
  get 'shipping' =>  'checkout#shipping', as: :shipping
  post 'shipping' => 'checkout#process_shipping', as: :process_shipping

  get 'receipts/:id' => 'checkout#receipt', as: :receipt


end
