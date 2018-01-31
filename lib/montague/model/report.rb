module Montague
  module Model
    # Report
    #
    class Report

      # @return [Montague::Model::Header]
      attr_accessor :header

      # @return [Array<Montague::Model::Journal>]
      attr_accessor :journals

      # @return [Array<Montague::Model::Publisher>]
      attr_accessor :publishers
    end
  end
end