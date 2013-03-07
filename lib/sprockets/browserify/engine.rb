require 'sprockets/browserify'

if defined?(Rails)
  module Sprockets
    class Browserify

      class Engine < ::Rails::Engine
        initializer :setup_browserify, :after => "sprockets.environment", :group => :all do |app|
          app.assets.register_postprocessor 'application/javascript', Browserify
        end
      end

    end
  end
end
