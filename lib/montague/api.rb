require 'http'

module Montague
  # Requests for a resource
  #
  class API
    # @param config [Hash]
    # @option config [String] :api_url URL of the SHERPA/RoMEO service
    # @option config [String] :api_key API key of the SHERPA/RoMEO service user
    def initialize(config = {})
      @config = config
      @config[:api_url] = 'http://www.sherpa.ac.uk/romeo/api29.php' unless config[:api_url]
    end

    # @param issn [String] ISSN e.g. 1234-5678.
    # @return [Montague::XMLExtractor::Journal, nil] XMLExtractor instance if successful.
    def find_by_issn(issn)
      url = "#{@config[:api_url]}?issn=#{issn}&ak=#{@config[:api_key]}"
      response = HTTP.get url
      if response.code === 200
        xml_extractor = Montague::XMLExtractor::Journal.new response.to_s
        xml_extractor.hits === 1 ? xml_extractor : nil
      end
    end
  end
end