module Montague
  module XMLExtractor
    # Journal XML extractor
    #
    class Journal < Montague::XMLExtractor::Base

      def initialize(xml)
        super
      end

      # @return [Array<Montague::Model::Journal>]
      def models
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

      # @return [Montague::Model::Journal]
      def model
        models.first unless models.empty?
      end

    end
  end
end
