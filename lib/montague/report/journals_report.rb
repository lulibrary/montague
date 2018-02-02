module Montague
  module Report
    # Journal report
    #
    class JournalsReport

      def initialize(response)
        @response = response
        @header_extractor = Montague::XMLExtractor::Header.new response.to_s
        @journal_extractor = Montague::XMLExtractor::Journal.new response.to_s
        @publisher_extractor = Montague::XMLExtractor::Publisher.new response.to_s
      end

      # @return [Montague::Model::JournalsReport]
      def report
        h = Montague::Model::JournalsReport.new
        h.http_response = @response
        h.header = @header_extractor.model
        h.journals = @journal_extractor.models
        h.publisher = @publisher_extractor.model
        h
      end

    end
  end
end
