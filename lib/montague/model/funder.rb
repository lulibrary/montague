module Montague
  module Model

    # Funder
    #
    class Funder < Montague::Model::Structure

      # @return [String, nil]
      attr_reader :acronym

      # @return [String, nil]
      attr_reader :name

      # @param v [String]
      def acronym=(v)
        @acronym = v if v && !v.empty?
      end

      # @param v [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

    end
  end
end