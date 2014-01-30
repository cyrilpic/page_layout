module PageLayout
  class Base
    attr_reader :name, :fields, :main_field, :main_options
    def initialize(name)
      @name = name
      @fields = {}
      @main_field = false
      @main_options = {}
    end
    
    def main(options = {})
      @main_field = true
      @main_options = options
    end
    
    def additional(key, options = {})
      return if key == :body
      @fields[key.to_sym] = options
    end
    
    def parse(body)
      params = {}
      body.gsub!(/<% content_for :(?<key>[a-z0-9_]+) do %>\r\n|\r|\n(?<content>.+)\r\n|\r|\n<% end #content_\k<key> %>\r\n|\r|\n/m) do |match|
        params[$1.to_sym] = $2
        ""
      end
      params[:body] = body if @main_field
      params
    end
    
    def generate(params)
      body = ""
      @fields.select {|k,v| params.has_key?(k) } .each_key do |k|
        body << "<% content_for :#{k} do %>\n"
        body << params[k]
        body << "\n<% end #content_#{k} %>\n"
      end
      body << params[:body] if @main_field
      body
    end
    
  end
end