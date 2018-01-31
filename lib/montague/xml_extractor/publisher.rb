module Montague
  module XMLExtractor
    # Publisher XML extractor
    #
    class Publisher < Montague::XMLExtractor::Base

      def initialize(xml)
        super
      end

      # @return [String]
      def name_alias
        xpath_query_for_single_value '/publisher/alias'
      end

      # @return [Array<String>]
      def conditions
        xpath_query_for_multi_value '/publisher/conditions/condition'
      end

      # @return [Array<Montague::Model::CopyrightLink>]
      def copyright_links
        data = []
        xpath_result = xpath_query '/publisher/copyrightlinks/copyrightlink'
        xpath_result.each do |i|
          copyright_link = Montague::Model::CopyrightLink.new
          copyright_link.text = i.xpath('copyrightlinktext').text.strip
          copyright_link.url = i.xpath('copyrightlinkurl').text.strip
          data << copyright_link if copyright_link.data?
        end
        data
      end

      # @return [String]
      def id
        xpath_query_for_single_value '/publisher/@id'
      end

      # Publisher compliance with the open access mandates of research funding agencies
      # @return [Array<Montague::Model::Mandate>]
      def mandates
        xpath_result = xpath_query '/publisher/mandates/mandate'
        data = []
        xpath_result.each do |i|
          mandate = Montague::Model::Mandate.new
          funder = Montague::Model::Funder.new
          funder.name = i.xpath('funder/fundername').text.strip
          funder.acronym = i.xpath('funder/funderacronym').text.strip
          mandate.funder = funder if funder.data?
          mandate.publisher_complies = i.xpath('publishercomplies').text.strip
          mandate.compliance_type = i.xpath('compliancetype').text.strip
          mandate.selected_titles = i.xpath('selectedtitles').text.strip
          data << mandate if mandate.data?
        end
        data
      end

      # @return [String, nil]
      def name
        xpath_query_for_single_value '/publisher/name'
      end


      # @return [Montague::Model::PaidAccess, nil]
      def paid_access
        xpath_result = xpath_query '/publisher/paidaccess'
        if !xpath_result.empty?
          paid_access = Montague::Model::PaidAccess.new
          paid_access.url = xpath_result.xpath('paidaccessurl').text.strip
          paid_access.name = xpath_result.xpath('paidaccessname').text.strip
          paid_access.notes = xpath_result.xpath('paidaccessnotes').text.strip
          paid_access
        end
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

      # @return [Montague::Model::Archiving, nil]
      def pdf_version
        paths = {
          archiving: 'pdfversion',
          permission: 'pdfarchiving',
          restrictions: 'pdfrestrictions'
        }
        prints paths
      end

      # @return [String, nil]
      def romeo_colour
        xpath_query_for_single_value '/publisher/romeocolour'
      end

      # @return [Montague::Model::Publisher]
      def package_model
        m = Montague::Model::Publisher.new
        m.alias = name_alias
        m.conditions = conditions
        m.copyright_links = copyright_links
        m.id = id
        m.mandates = mandates
        m.name = name
        m.paid_access = paid_access
        m.pdf_version = pdf_version
        m.pre_prints = pre_prints
        m.post_prints = post_prints
        m.romeo_colour = romeo_colour
        m
      end

      # @return [Montague::Model::Publisher]
      def models
        data = []
        xpath_result = xpath_query publisher_path
        xpath_result.each do |i|
          xml_extractor = Montague::XMLExtractor::Publisher.new i.to_s
          # puts i.to_s
          data << xml_extractor.package_model
        end
        data
      end

      # @return [Montague::Model::Publisher]
      def model
        models.first unless models.empty?
      end

      private

      # @return [Montague::Model::Archiving, nil]
      def prints(paths)
        xpath_result = xpath_query "/publisher/#{paths[:archiving]}"
        if !xpath_result.empty?
          archiving = Montague::Model::Archiving.new
          archiving.permission = xpath_result.xpath(paths[:permission]).text.strip
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
