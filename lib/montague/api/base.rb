module Montague

  module API

    # Base API
    #
    class Base

      # @param config [Hash]
      # @option config [String] :api_url URL of the SHERPA/RoMEO service (if it changes)
      # @option config [String] :api_key API key of the SHERPA/RoMEO service user
      # @option config [String] :language 2-letter code (ISO 639-1) to get data in a language other than English (when possible)
      #   * en - English (default)
      #   * de - German
      #   * es - Spanish
      #   * hu - Hungarian
      #   * pt - Portuguese
      def initialize(config = {})
        @config = config
        @config[:api_url] = 'http://www.sherpa.ac.uk/romeo/api29.php' unless config[:api_url]
      end

      private

      def common_parameters
        "&showfunder=all&ak=#{@config[:api_key]}&la=#{language}"
      end

      def language
        whitelist = %w(en de es hu pt)
        whitelist.include?(@config[:language]) ? @config[:language] : 'en'
      end

    end

  end

end