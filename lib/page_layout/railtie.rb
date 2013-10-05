module PageLayout
  class Railtie < Rails::Railtie
    config.to_prepare do
      PageLayout.setup!
    end
  end
end