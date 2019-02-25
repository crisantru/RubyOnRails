Rails.application.routes.draw do
  resources :inventories_stocks

  resources :providers
 
  get "providers/buscar_por_nombre"
  get 'providers/buscar_por_nombre/:name', :to => 'providers#buscar_por_nombre'
  get "providers/buscar_por_state"
  get 'providers/buscar_por_state/:state', :to => 'providers#buscar_por_state'


  resources :shipments_articles

  resources :sales_articles

  resources :articles_orders do 
      get 'seleccionado'
  end

  resources :articles_bills

  resources :shipments
  get "shipments/buscar_por_id"
  get 'shipments/buscar_por_id/:shipment_id', :to => 'shipments#buscar_por_id'
  get "shipments/buscar_por_cliente"
  get 'shipments/buscar_por_cliente/:client_id', :to => 'shipments#buscar_por_cliente'
  get "shipments/buscar_por_status"
  get 'shipments/buscar_por_status/:status', :to => 'shipments#buscar_por_status'

  resources :users
  get "users/buscar_por_id"
  get 'users/buscar_por_id/:user', :to => 'users#buscar_por_id'
  get "users/buscar_por_name"
  get 'users/buscar_por_name/:name', :to => 'users#buscar_por_name'
  
  resources :stocks
  get "stocks/buscar_stock_por_id"
  get 'stocks/buscar_stock_por_id/:stock_id', :to => 'stocks#buscar_stock_por_id'
  get "stocks/buscar_stock_por_direccion"
  get 'stocks/buscar_stock_por_direccion/:address', :to => 'stocks#buscar_stock_por_direccion'
  get "stocks/buscar_stock_por_sucursal"
  get 'stocks/buscar_stock_por_sucursal/:branch', :to => 'stocks#buscar_stock_por_sucursal'
  
  resources :staff_types
  get "staff_types/buscar_por_puesto"
  get 'staff_types/buscar_por_puesto/:type', :to => 'staff_types#buscar_por_puesto'

  resources :staffs
  get "staffs/buscar_por_nombre"
  get 'staffs/buscar_por_nombre/:nombre', :to => 'staffs#buscar_por_nombre'  
  get "staffs/buscar_por_apellido"
  get 'staffs/buscar_por_apellido/:apellido', :to => 'staffs#buscar_por_apellido'
  get "staffs/buscar_por_telefono"
  get 'staffs/buscar_por_telefono/:telefono', :to => 'staffs#buscar_por_telefono'
  get "staffs/buscar_por_sucursal"
  get 'staffs/buscar_por_sucursal/:sucursal', :to => 'staffs#buscar_por_sucursal'

  resources :sales
  get "sales/buscar_por_id"
  get 'sales/buscar_por_id/:sale_id', :to => 'sales#buscar_por_id' 
  get "sales/buscar_por_fecha"
  get 'sales/buscar_por_fecha/:sale_date', :to => 'sales#buscar_por_fecha'
  get "sales/buscar_por_cliente"
  get 'sales/buscar_por_cliente/:client', :to => 'sales#buscar_por_cliente' 
  get "sales/buscar_por_tipo_venta"
  get 'sales/buscar_por_tipo_venta/:type', :to => 'sales#buscar_por_tipo_venta'
  get "sales/buscar_por_empleado"
  get 'sales/buscar_por_empleado/:empleado', :to => 'sales#buscar_por_empleado'  

  resources :orders
  get "orders/buscar_por_fecha"
  get 'orders/buscar_por_fecha/:fecha', :to => 'orders#buscar_por_fecha' 
  get "orders/buscar_por_almacen"
  get 'orders/buscar_por_almacen/:almacen', :to => 'orders#buscar_por_almacen'      

  resources :inventories

  get "inventories/buscar_por_id"
  get 'inventories/buscar_por_id/:inventorie_id', :to => 'inventories#buscar_por_id'
  get "inventories/buscar_por_sucursal"
  get 'inventories/buscar_por_sucursal/:branch_id', :to => 'inventories#buscar_por_sucursal'


  resources :clients
  get "clients/buscar_por_nombre"
  get 'clients/buscar_por_nombre/:nombre', :to => 'clients#buscar_por_nombre'
  get "clients/buscar_por_rfc"
  get 'clients/buscar_por_rfc/:rfc', :to => 'clients#buscar_por_rfc'    
  get "clients/buscar_por_telefono"
  get 'clients/buscar_por_telefono/:telefono', :to => 'clients#buscar_por_telefono'    

  resources :branches
  get "branches/buscar_por_id"
  get 'branches/buscar_por_id/:branch', :to => 'branches#buscar_por_id'
  get "branches/buscar_por_state"
  get 'branches/buscar_por_state/:state', :to => 'branches#buscar_por_state'
  get "branches/buscar_por_name"
  get 'branches/buscar_por_name/:name', :to => 'branches#buscar_por_name'

  resources :bills
  get "bills/buscar_por_fecha"
  get 'bills/buscar_por_fecha/:fecha', :to => 'bills#buscar_por_fecha'
  get "bills/buscar_por_cliente"
  get 'bills/buscar_por_cliente/:cliente', :to => 'bills#buscar_por_cliente'  

  resources :articles
  get "articles/buscar_por_categoria"
  get 'articles/buscar_por_categoria/:categoria', :to => 'articles#buscar_por_categoria'  
  get "articles/buscar_por_marca"
  get 'articles/buscar_por_marca/:marca', :to => 'articles#buscar_por_marca'
  get "articles/buscar_por_modelo"
  get 'articles/buscar_por_modelo/:modelo', :to => 'articles#buscar_por_modelo'

  resources :welcomes
  get "cerrar_sesion", :to => "welcomes#cerrar_sesion"
  get "bienvenido", :to => "welcomes#bienvenido"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcomes#index'
    
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
