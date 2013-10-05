require "page_layout/version"

module PageLayout
  extend ActiveSupport::Autoload
  
  autoload :Base
  autoload :ViewHelper
  autoload :ModelHelper
  autoload :Model
  
  mattr_accessor :path
  @@path = Rails.root.join("app","pages","*.rb")
  
  mattr_accessor :pages
  @@pages = {}
  
  @@loaded = false
  
  def self.build(name, &block)
    plb = Base.new name.to_sym
    plb.instance_eval(&block)
    pages[name.to_sym] = plb
  end
  def self.load_pages
    Dir[@@path].each {|file| require file} unless @@loaded
    @loaded = true
  end
  def self.get(name)
    self.load_pages
    raise Exception, "#{name} page layout does not exist." unless @@pages.has_key?(name.to_sym)
    pages[name.to_sym]
  end
  def self.get_all
    self.load_pages
    pages
  end
  
end