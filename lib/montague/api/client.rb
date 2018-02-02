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
      # @return [Montague::Model::JournalsReport]
      def find_by_journal_issn(issn)
        url = "#{@config[:api_url]}?issn=#{issn}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        journals_report response
      end

      # @param title [String] Multiple words treated as a single string. Case insensitive.
      # @param filter [Symbol]
      #   * :exact - Verbatim e.g. 'Journal of Geology'
      #   * :starts - Starts with e.g. 'machine'
      #   * :contains - Contains e.g. 'modern language'
      # @return [Montague::Model::JournalsReport]
      def find_by_journal_title(title:, filter: :exact)
        url = "#{@config[:api_url]}?jtitle=#{title}&qtype=#{filter}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        journals_report response
      end

      # @param id [Fixnum] RoMEO persistent ID
      # @return [Montague::Model::PublisherReport]
      def find_by_publisher_id(id)
        url = "#{@config[:api_url]}?id=#{id}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        publisher_report response
      end

      # @param name [String] e.g. 'optical society'
      # @param filter [Symbol]
      #   * :all - All words present but in any order or location
      #   * :any - At least one of the words present
      #   * :exact - Intact phrase somewhere e.g. 'tute of'
      # @return [Montague::Model::PublishersReport]
      def find_by_publisher_name(name:, filter: :all)
        url = "#{@config[:api_url]}?pub=#{name}&qtype=#{filter}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        publishers_report response
      end

      private

      def common_parameters
        "&showfunder=all&ak=#{@config[:api_key]}"
      end

      # @return [Montague::Model::JournalsReport]
      def journals_report(response)
        xml_extractor = Montague::Report::JournalsReport.new response
        xml_extractor.report
      end

      # @return [Montague::Model::PublishersReport]
      def publishers_report(response)
        xml_extractor = Montague::Report::PublishersReport.new response
        xml_extractor.report
      end

      # @return [Montague::Model::PublisherReport]
      def publisher_report(response)
        xml_extractor = Montague::Report::PublisherReport.new response
        xml_extractor.report
      end

    end

  end

end