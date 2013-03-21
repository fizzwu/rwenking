# codeing: utf-8
require 'rest-client'
require 'cgi'
require 'nokogiri'

module RWenking
  class Client
    def initialize(options)
      return nil until options
      @appname = options[:appname]
      @key = options[:appkey]
    end

    def scan(options)
      apiurl = "http://antiphishing.aliyun-inc.com/commonrecv"
      url = CGI.escape(options[:url])
      extra_data = options[:extradata]
      response = RestClient.post(apiurl, {:sign => sign(@key, url), :appname => @appname, :url => url, :extradata => extra_data})
      return response.body
    end

    def get_phish(id=nil)
      apiurl = "http://antiphishing.aliyun-inc.com/commonget"
      id ||= 0
      response = RestClient.get(apiurl, {:params => {:appname => @appname, :id => id, :sign => sign(@key, id)}})
      xml = Nokogiri::XML(response.body)
      xml.xpath("//item").map do |i|
        {'id' => i.xpath('url').attr('id').value ,'url' => i.xpath('url').inner_text, 'extradata' => i.xpath('extradata').inner_text}
      end
    end

    private
    def sign(key, urlstr)
      Digest::MD5.hexdigest("#{key}#{urlstr}#{key}")
    end
  end
end