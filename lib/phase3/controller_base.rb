require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      file_name = File.join("views/", "#{self.class.name.underscore}", "/#{template_name}.html.erb")
      file = File.read(file_name)
      new_template = ERB.new(file).result(binding)

      render_content(new_template, 'text/html')

    end
  end
end
