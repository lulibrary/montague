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

      # @return [Array<Montague::Model::Mandate>]
      def mandates
        xpath_result = xpath_query File.join(publisher_path, 'mandates/mandate')
        data = []
        xpath_result.each do |i|
          mandate = Montague::Model::Mandate.new
          mandate.funder_name = i.xpath('funder/fundername').text.strip
          mandate.funder_acronym = i.xpath('funder/funderacronym').text.strip
          mandate.publisher_complies = i.xpath('publishercomplies').text.strip
          mandate.compliance_type = i.xpath('compliancetype').text.strip
          mandate.selected_titles = i.xpath('selectedtitles').text.strip
          data << mandate if mandate.data?
        end
        data
      end

      # @return [Montague::Model::PaidAccess, nil]
      def paid_access
        xpath_result = xpath_query File.join(publisher_path, 'paidaccess')
        if !xpath_result.empty?
          paid_access = Montague::Model::PaidAccess.new
          paid_access.url = xpath_result.xpath('paidaccessurl').text.strip
          paid_access.name = xpath_result.xpath('paidaccessname').text.strip
          paid_access.notes = xpath_result.xpath('paidaccessnotes').text.strip
          paid_access
        end
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
          archiving: 'preprints',
          permission: 'prearchiving',
          restrictions: 'prerestrictions'
        }
        prints paths
      end

      # @return (see #prints)
      def post_prints
        paths = {
          archiving: 'postprints',
          permission: 'postarchiving',
          restrictions: 'postrestrictions'
        }
        prints paths
      end

      # @return (see #prints)
      def pdf_version
        paths = {
          archiving: 'pdfversion',
          permission: 'pdfarchiving',
          restrictions: 'pdfrestrictions'
        }
        prints paths
      end

      # @return [Array<String>]
      def conditions
        xpath_query_for_multi_value File.join publisher_path, 'conditions/condition'
      end

      # @return [Array<Montague::Model::CopyrightLink>]
      def copyright_links
        data = []
        xpath_result = xpath_query File.join(publisher_path, 'copyrightlinks/copyrightlink')
        xpath_result.each do |i|
          copyright_link = Montague::Model::CopyrightLink.new
          copyright_link.text = i.xpath('copyrightlinktext').text.strip
          copyright_link.url = i.xpath('copyrightlinkurl').text.strip
          data << copyright_link if copyright_link.data?
        end
        data
      end

      private

      # @return [Montague::Model::Archiving, nil]
      def prints(paths)
        xpath_result = xpath_query File.join(publisher_path, paths[:archiving])
        if !xpath_result.empty?
          archiving = Montague::Model::Archiving.new
          archiving.permission = xpath_result.xpath paths[:permission]
          archiving.restrictions = []
          restrictions = xpath_result.xpath paths[:restrictions]
          restrictions.each do |i|
            archiving.restrictions << i.text.strip if !i.text.empty?
          end
          archiving
        end
      end

    end
  end
end
