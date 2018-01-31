module Montague

  module API

    # Base API
    #
    class Base
      # @param config [Hash]
      # @option config [String] :api_url URL of the SHERPA/RoMEO service (if it changes)
      # @option config [String] :api_key API key of the SHERPA/RoMEO service user
      def initialize(config = {})
        @config = config
        @config[:api_url] = 'http://www.sherpa.ac.uk/romeo/api29.php' unless config[:api_url]
      end

      private

      def common_parameters
        "&showfunder=all&ak=#{@config[:api_key]}"
      end

      # @return [Montague::Model::Report]
      def report(response)
        return unless response.code === 200
        xml_extractor = Montague::XMLExtractor::Report.new response.to_s
        xml_extractor.report
      end

    end

  end

end