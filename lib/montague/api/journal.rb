module Montague

  module API

    # Journal API
    #
    class Journal < Montague::API::Base

      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @param partial_title [String] Partial journal title e.g. 'modern language'
      # @return [Array<Montague::Model::Journal>, nil]
      def find_by_title_contains(partial_title)
        url = "#{@config[:api_url]}?jtitle=#{partial_title}&qtype=contains#{common_parameters}"
        response = HTTP.get URI.encode(url)
        package_journals response
      end

      # @param partial_title [String] Partial journal title e.g. 'Machine'
      # @return [Array<Montague::Model::Journal>, nil]
      def find_by_title_starts(partial_title)
        url = "#{@config[:api_url]}?jtitle=#{partial_title}&qtype=starts#{common_parameters}"
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