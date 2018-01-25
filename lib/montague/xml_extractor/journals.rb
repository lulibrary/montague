module Montague
  module XMLExtractor
    # Journals XML extractor
    #
    class Journals < Montague::XMLExtractor::Base

      def initialize(xml)
        super
      end

      # @return [Array<Montague::Model::JournalHeader>]
      def journals
        data = []
        xpath_result = xpath_query journal_path
        xpath_result.each do |i|
          journal_header = Montague::Model::JournalHeader.new
          journal_header.title = i.xpath('jtitle').text.strip
          journal_header.issn = i.xpath('issn').text.strip
          data << journal_header
        end
        data
      end

    end
  end
end
