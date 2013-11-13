module PageLayout
  class Engine < Rails::Engine
    config.to_prepare do
      PageLayout.setup!
    end
  end
end