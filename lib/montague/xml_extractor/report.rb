module Montague
  module XMLExtractor
    # Report XML extractor
    #
    class Report

      def initialize(xml)
        @header_extractor = Montague::XMLExtractor::Header.new xml
        @journal_extractor = Montague::XMLExtractor::Journal.new xml
        @publisher_extractor = Montague::XMLExtractor::Publisher.new xml
      end

      # @return [Montague::Model::Report]
      def report
        h = Montague::Model::Report.new
        h.header = @header_extractor.model
        h.journals = @journal_extractor.models
        h.publishers = @publisher_extractor.models
        h
      end

    end
  end
end
