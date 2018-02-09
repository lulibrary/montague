module Montague
  module Model

    # Publisher
    #
    class Publisher

      # @return [String]
      attr_accessor :alias

      # @return [Array<String>]
      attr_accessor :conditions

      # @return [Array<Montague::Model::CopyrightLink>]
      attr_accessor :copyright_links

      # @return [String]
      attr_accessor :id

      # Publisher compliance with the open access mandates of research funding agencies
      # @return [Array<Montague::Model::Mandate>]
      attr_accessor :mandates

      # @return [String, nil]
      attr_accessor :name

      # @return [Montague::Model::PaidAccess, nil]
      attr_accessor :paid_access

      # Publisher version, with formatting
      # @return [Montague::Model::Archiving, nil]
      attr_accessor :pdf_version

      # Submitted version, before peer-review
      # @return [Montague::Model::Archiving, nil]
      attr_accessor :pre_prints

      # Accepted version, after peer-review
      # @return [Montague::Model::Archiving, nil]
      attr_accessor :post_prints

      # @return [String, nil]
      attr_accessor :romeo_colour
    end
  end
end