Rails.application.routes.draw do
  
  resources :users

  get 'static_products/catalogo'

  get 'static_products/ribbons'

  get 'static_products/sujetadores'

  get 'static_products/etiquetas'

  get 'static_products/aplicadores_manuales'

  get 'static_products/maquinas_etiquetadoras'

  get 'static_products/impresoras_codigo_barras'

  get '/static_products/:id', to: 'static_products#show', as: 'static_product'

  get 'welcome/index'

  resources :whoares
  resources :products
  resources :services

  root 'welcome#index'


end
