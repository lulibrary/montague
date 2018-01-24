module Montague
  module XMLExtractor
    # Journal XML extractor
    #
    class Journal < Montague::XMLExtractor::Base

      def initialize(xml)
        super
      end

      # @return [String, nil]
      def issn
        xpath_query_for_single_value File.join journal_path, 'issn'
      end

      # @return [Array<Hash{Symbol}>]
      def mandates
        data = []
        mandates = xpath_query File.join(publisher_path, 'mandates/mandate')
        mandates.each do |i|
          mandate = {}
          mandate[:funder_name] = i.xpath('funder/fundername').text.strip
          mandate[:funder_acronym] = i.xpath('funder/funderacronym').text.strip
          mandate[:publisher_complies] = i.xpath('publishercomplies').text.strip
          mandate[:compliance_type] = i.xpath('compliancetype').text.strip
          mandate[:selected_titles] = i.xpath('selectedtitles').text.strip
          data << mandate
        end
        data
      end

      # @return [Hash{Symbol}]
      def paid_access
        data = {}
        data[:url] = xpath_query_for_single_value File.join publisher_path, 'paidaccess/paidaccessurl'
        data[:name] = xpath_query_for_single_value File.join publisher_path, 'paidaccess/paidaccessname'
        data[:notes] = xpath_query_for_single_value File.join publisher_path, 'paidaccess/paidaccessnotes'
        data
      end

      # @return [String, nil]
      def publisher
        xpath_query_for_single_value File.join publisher_path, 'name'
      end

      # @return [String, nil]
      def romeo_colour
        xpath_query_for_single_value File.join publisher_path, 'romeocolour'
      end

      # @return [String, nil]
      def title
        xpath_query_for_single_value File.join journal_path, 'jtitle'
      end

      # @return (see #prints)
      def pre_prints
        paths = {
          archiving: File.join(publisher_path, 'preprints/prearchiving'),
          restrictions: File.join(publisher_path, 'preprints/prerestrictions')
        }
        prints paths
      end

      # @return (see #prints)
      def post_prints
        paths = {
          archiving: File.join(publisher_path, 'postprints/postarchiving'),
          restrictions: File.join(publisher_path, 'postprints/postrestrictions')
        }
        prints paths
      end

      # @return (see #prints)
      def pdf_version
        paths = {
          archiving: File.join(publisher_path, '/pdfversion/pdfarchiving'),
          restrictions: File.join(publisher_path, 'pdfversion/pdfrestrictions')
        }
        prints paths
      end

      # @return [Array<String>]
      def conditions
        xpath_query_for_multi_value File.join publisher_path, 'conditions/condition'
      end

      # @return [Array<Hash{Symbol}>]
      def copyright_links
        data = []
        copyright_links = xpath_query File.join(publisher_path, 'copyrightlinks/copyrightlink')
        copyright_links.each do |i|
          copyright_link = {}
          copyright_link[:text] = i.xpath('copyrightlinktext').text.strip
          copyright_link[:url] = i.xpath('copyrightlinkurl').text.strip
          data << copyright_link
        end
        data
      end

      private

      # @return [Hash{Symbol => String, Symbol => Array<String}>]
      def prints(paths)
        data = {}
        data[:archiving] = xpath_query_for_single_value paths[:archiving]
        data[:restrictions] = []
        restrictions = xpath_query paths[:restrictions]
        restrictions.each do |i|
          data[:restrictions] << i.text.strip if !i.text.empty?
        end
        data
      end

    end
  end
end
