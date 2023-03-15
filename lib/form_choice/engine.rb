require "form_choice"

module FormChoice
  class Engine < ::Rails::Engine
    isolate_namespace FormChoice

    config.autoload_once_paths = %W(#{root}/app/helpers #{root}/app/models)


    initializer "form_choice.helper" do
      %i[action_controller_base action_mailer].each do |abstract_controller|
        ActiveSupport.on_load(abstract_controller) do
          helper FormChoice::Engine.helpers
        end
      end
    end

    initializer "form_choice.asset" do
      if Rails.application.config.respond_to?(:assets)
        Rails.application.config.assets.precompile += %w( choices.js.js form_choice.js form_choice.css )
      end
    end
  end
end
