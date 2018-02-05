module Montague
  module Reporter
    # Journal reporter
    #
    class Journal

      def initialize(response)
        @response = response
        @header_extractor = Montague::XMLExtractor::Header.new response.to_s
        @journal_extractor = Montague::XMLExtractor::Journal.new response.to_s
        @publisher_extractor = Montague::XMLExtractor::Publisher.new response.to_s
      end

      # @return [Montague::Model::JournalsReport]
      def report
        h = Montague::Model::JournalReport.new
        h.http_response = @response
        h.header = @header_extractor.model
        h.journal = @journal_extractor.model
        h.publisher = @publisher_extractor.model
        h
      end

    end
  end
end
