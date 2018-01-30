module Montague
  module Model

    # Publisher
    #
    class Publisher < Montague::Model::Base

      # @return [Array<String>]
      attr_accessor :conditions

      # @return [Array<Montague::Model::CopyrightLink>]
      attr_accessor :copyright_links

      # @return [Fixnum]
      attr_accessor :id

      # Publisher compliance with the open access mandates of research funding agencies
      # @return [Array<Montague::Model::Mandate>]
      attr_accessor :mandates

      # @return [String, nil]
      attr_accessor :name

      # @return [Montague::Model::PaidAccess, nil]
      attr_accessor :paid_access

      # @return [Montague::Model::Archiving, nil]
      attr_accessor :pdf_version

      # @return [Montague::Model::Archiving, nil]
      attr_accessor :pre_prints

      # @return [Montague::Model::Archiving, nil]
      attr_accessor :post_prints

      # @return [String, nil]
      attr_accessor :romeo_colour
    end
  end
end