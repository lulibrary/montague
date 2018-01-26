module Montague
  module XMLExtractor
    # Journals XML extractor
    #
    class Journals < Montague::XMLExtractor::Base

      def initialize(xml)
        super
      end

      # @return [Array<Montague::Model::PublisherReport>]
      def journals
        data = []
        xpath_result = xpath_query journal_path
        xpath_result.each do |i|
          journal = Montague::Model::Journal.new
          journal.title = i.xpath('jtitle').text.strip
          journal.issn = i.xpath('issn').text.strip
          data << journal
        end
        data
      end

    end
  end
end
