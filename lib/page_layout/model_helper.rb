module PageLayout
  module ModelHelper
    extend ActiveSupport::Concern
    
    def page_layout
      if @page_layout.nil?
        @page_layout = PageLayout::Model.new
        prepare_for_editing
      end
      @page_layout
    end
    def page_layout=(hash)
      page_layout.attributes = hash
    end
    
    
    included do
      attr_accessible :page_layout_attributes
      has_one :page_layout, class_name: 'PageLayout::Model'
      accepts_nested_attributes_for :page_layout
      def page_layout_attributes= hash
        self.page_layout = hash
      end
      def prepare_for_editing
        self.page_layout = PageLayout.get(self.page_info.template).parse(self.body || "") unless self.page_info.nil? || self.page_info.template.blank?
      end
      before_validation do
        unless body_changed?
          self.body = PageLayout.get(self.page_info.template).generate(self.page_layout.attributes)
        end
      end
    end
    
  end
end