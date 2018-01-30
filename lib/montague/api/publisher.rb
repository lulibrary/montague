module Montague

  module API

    # Publisher API
    #
    class Publisher < Montague::API::Base

      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @param issn [String] International Standard Serial Number e.g. 1234-5678.
      # @return (see #package_report)
      def find_by_journal_issn(issn)
        url = "#{@config[:api_url]}?issn=#{issn}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_report response
      end

      # @param title [String] Journal title e.g. 'Journal of Geology'
      # @return (see #package_report)
      def find_by_journal_title_exact(title)
        url = "#{@config[:api_url]}?jtitle=#{title}&qtype=exact#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_report response
      end

      # @param words [String] All words present but in any order or location e.g. 'optical society'
      # @return (see #package_publishers)
      def find_by_name_all(words)
        find_by_name_x words, 'all'
      end

      # @param words [String] At least one of the words present e.g. 'chemistry society'
      # @return (see #package_publishers)
      def find_by_name_any(words)
        find_by_name_x words, 'any'
      end

      # @param words [String] Intact phrase somewhere e.g. 'tute of'
      # @return (see #package_publishers)
      def find_by_name_exact(words)
        find_by_name_x words, 'exact'
      end

      # @param id [Fixnum]
      # @return (see #package_publisher)
      def find_by_id(id)
        url = "#{@config[:api_url]}?id=#{id}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_publisher response
      end

      private

      # @return [Montague::Model::PublisherReport, nil]
      def package_report(response)
        return unless response.code === 200
        xml_extractor = Montague::XMLExtractor::PublisherReport.new response.to_s
        xml_extractor.report
      end

      # @return [Array<Montague::Model::Publisher>, nil]
      def package_publishers(response)
        return unless response.code === 200
        xml_extractor = Montague::XMLExtractor::Publisher.new response.to_s
        xml_extractor.hits > 0 ? xml_extractor.models : nil
      end

      # @return [Montague::Model::Publisher, nil]
      def package_publisher(response)
        return unless response.code === 200
        xml_extractor = Montague::XMLExtractor::Publisher.new response.to_s
        xml_extractor.hits === 1 ? xml_extractor.model : nil
      end

      def find_by_name_x(words, type)
        url = "#{@config[:api_url]}?pub=#{words}&qtype=#{type}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_publishers response
      end

    end

  end

end