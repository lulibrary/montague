module Montague

  module API

    # Journal API
    #
    class Journal < Montague::API::Base

      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @param partial_title [String] Partial journal title e.g. 'modern language'. Multiple words treated as a single string.
      # @return [Array<Montague::Model::Journal>, nil]
      def find_by_title_contains(partial_title)
        url = "#{@config[:api_url]}?jtitle=#{partial_title}&qtype=contains#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_journals response
      end

      # @param partial_title [String] Partial journal title e.g. 'Machine'. Multiple words treated as a single string.
      # @return [Array<Montague::Model::Journal>, nil]
      def find_by_title_starts(partial_title)
        url = "#{@config[:api_url]}?jtitle=#{partial_title}&qtype=starts#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_journals response
      end

      # @param title [String] Journal title e.g. 'Journal of Geology'. Multiple words treated as a single string.
      # @return (see #package_report)
      def find_by_journal_title_exact(title)
        url = "#{@config[:api_url]}?jtitle=#{title}&qtype=exact#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_journals response
      end

      private

      # @return [Array<Montague::Model::Journal>, nil]
      def package_journals(response)
        return unless response.code === 200
        xml_extractor = Montague::XMLExtractor::Journal.new response.to_s
        xml_extractor.hits > 0 ? xml_extractor.models : nil
      end

    end

  end

end