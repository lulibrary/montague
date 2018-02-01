module Montague

  module API

    # API client
    #
    class Client
      # @param config [Hash]
      # @option config [String] :api_url URL of the SHERPA/RoMEO service (if it changes)
      # @option config [String] :api_key API key of the SHERPA/RoMEO service user
      def initialize(config = {})
        @config = config
        @config[:api_url] = 'http://www.sherpa.ac.uk/romeo/api29.php' unless config[:api_url]
      end

      # @param issn [String] International Standard Serial Number e.g. 1234-5678.
      # @return (see #report)
      def find_by_journal_issn(issn)
        url = "#{@config[:api_url]}?issn=#{issn}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
      end

      # @param title [String] Multiple words treated as a single string. Case insensitive.
      # @param filter [Symbol]
      #   * :contains - Contains e.g. 'modern language'
      #   * :starts - Starts with e.g. 'machine'
      #   * :exact - Verbatim e.g. 'Journal of Geology'
      # @return (see #report)
      def find_by_journal_title(title:, filter:)
        url = "#{@config[:api_url]}?jtitle=#{title}&qtype=#{filter}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
      end

      # @param id [String]
      # @return (see #report)
      # @note Montague::Model::Report#journals is always empty
      def find_by_publisher_id(id)
        url = "#{@config[:api_url]}?id=#{id}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
      end

      # @param name [String] e.g. 'optical society'
      # @param filter [Symbol]
      #   * :all - All words present but in any order or location
      #   * :any - At least one of the words present
      #   * :exact - Intact phrase somewhere e.g. 'tute of'
      # @return (see #report)
      # @note Montague::Model::Report#journals is always empty
      def find_by_publisher_name(name:, filter:)
        url = "#{@config[:api_url]}?pub=#{name}&qtype=#{filter}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
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