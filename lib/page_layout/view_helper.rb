module PageLayout
  module ViewHelper
    def page_layout_fields(pl, form)
      html = ''
      html << page_layout_field(form, :body, pl.main_options) if pl.main_field
      pl.fields.each do |name, options|
        html << page_layout_field(form, name, options)
      end
      html.html_safe
    end
    def page_layout_field(form, name, options)
      form.input name, normalize_options(options)
    end
    private
    def normalize_options(opt)
      options = { as: :text }
      if opt.has_key?(:ckeditor) && opt[:ckeditor]
        options[:input_html] = { class: 'ckeditor' }
      end
      options
    end
  end
end