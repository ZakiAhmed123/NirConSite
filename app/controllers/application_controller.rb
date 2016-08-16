class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order
  helper_method :current_or_guest_user
  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user

    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        guest_user(with_retry = false).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  private

  def create_guest_user
    u = User.create(:email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

  def self.guest_checkout(amount, stripe_token, user, logger)
       stripe_gateway = StripeGateway.new(logger)
       customer_id = stripe_gateway.charge(amount, stripe_token)

       user.save_stripe_customer_id(customer_id)
     end

  def fetch_products
    @products=[]
    CSV.foreach("embeds.csv",headers:true) do |row|
      product=Product.new
      product.id=row.to_h['id']
      product.length=row.to_h['length']
      product.width=row.to_h['width']
      product.thickness=row.to_h['thickness']
      product.stud_count=row.to_h['stud_count']
      product.stud_thickness=row.to_h['stud_thickness']
      product.stud_length=row.to_h['stud_length']
      product.total_weight=row.to_h['total_weight']
      product.price=row.to_h['price']
      product.shipping_cost=row.to_h['shipping_cost']
      product.name=row.to_h['name']
      product.img_file=row.to_h['img_file']
      product.pdf=row.to_h['pdf']
      @products << product
    end
    @products
  end

  def fetch_stabilizers
    @stabilizers=[]
    CSV.foreach('stabilizers.csv', headers:true) do |row|
      stabilizer=Product.new
      stabilizer.id=row.to_h['id']
      stabilizer.name=row.to_h['name']
      stabilizer.shipping_cost=row.to_h['shipping_cost']
      stabilizer.price=row.to_h['price']
      stabilizer.img_file=row.to_h['img_file']
      stabilizer.pdf=row.to_h['pdf']
      @stabilizers << stabilizer
    end
    @stabilizers
  end


end
