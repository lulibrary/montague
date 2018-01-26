module Montague

  module API

    # Journal API
    #
    class Journal < Montague::API::Base

      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @param issn [String] International Standard Serial Number e.g. 1234-5678.
      # @return [Montague::Model::PublisherReport, nil]
      def find_by_issn(issn)
        url = "#{@config[:api_url]}?issn=#{issn}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_journal response
      end

      # @param title [String] Journal title e.g. 'Journal of Geology'
      # @return [Montague::Model::PublisherReport, nil]
      def find_by_title(title)
        url = "#{@config[:api_url]}?jtitle=#{title}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_journal response
      end

      # @param partial_title [String] Partial journal title e.g. 'modern language'
      # @return [Array<Montague::Model::Journal>, nil]
      def find_by_partial_title(partial_title)
        url = "#{@config[:api_url]}?jtitle=#{partial_title}&qtype=contains#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_journals response
      end

      private

      # @return [Montague::Model::PublisherReport, nil]
      def package_journal(response)
        return unless response.code === 200
        xml_extractor = Montague::XMLExtractor::PublisherReport.new response.to_s
        xml_extractor.hits === 1 ? xml_extractor.model : nil
      end

      # @return [Array<Montague::Model::Journal>, nil]
      def package_journals(response)
        return unless response.code === 200
        xml_extractor = Montague::XMLExtractor::Journals.new response.to_s
        xml_extractor.hits > 0 ? xml_extractor.journals : nil
      end

    end

  end

end