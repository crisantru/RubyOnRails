require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module System
    # Settings in config/environments/* take precedence over those specified here.
  class Application < Rails::Application
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.precompile += %w( buscar_stock_por_id.js )
    config.assets.precompile += %w( buscar_articulos.js )
    config.assets.precompile += %w( buscar_clientes.js )
    config.assets.precompile += %w( buscar_compras.js )
    config.assets.precompile += %w( buscar_empleados.js )
    config.assets.precompile += %w( buscar_envios.js )
    config.assets.precompile += %w( buscar_inventarios.js )
    config.assets.precompile += %w( buscar_proveedores.js )
    config.assets.precompile += %w( buscar_tipo_empleados.js )
    config.assets.precompile += %w( buscar_por_sucursales.js )	
    config.assets.precompile += %w( buscar_por_usuarios.js )
    config.assets.precompile += %w( buscar_ventas.js )
    config.assets.precompile += %w( buscar_facturas.js )
  end
end
