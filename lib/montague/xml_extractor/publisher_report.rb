module Montague
  module XMLExtractor
    # Publisher report XML extractor
    #
    class PublisherReport

      def initialize(xml)
        @journal_extractor = Montague::XMLExtractor::Journal.new xml
        @publisher_extractor = Montague::XMLExtractor::Publisher.new xml
      end

      # @return [Montague::Model::PublisherReport, nil]
      def report
        return unless @publisher_extractor.hits === 1
        h = Montague::Model::PublisherReport.new
        h.journal = @journal_extractor.model
        h.publisher = @publisher_extractor.model
        h
      end

    end
  end
end
