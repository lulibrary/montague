module Montague
  module Model

    # Funder compliance mandate
    #
    class Mandate < Montague::Model::Structure

      # @return [String, nil]
      attr_reader :funder_name

      # @return [String, nil]
      attr_reader :funder_acronym

      # @return [String, nil]
      attr_reader :publisher_complies

      # @return [String, nil]
      attr_reader :compliance_type

      # @return [String, nil]
      attr_reader :selected_titles

      # @param v [String]
      def funder_name=(v)
        @funder_name = v if v && !v.empty?
      end

      # @param v [String]
      def funder_acronym=(v)
        @funder_acronym = v if v && !v.empty?
      end

      # @param v [String]
      def publisher_complies=(v)
        @publisher_complies = v if v && !v.empty?
      end

      # @param v [String]
      def compliance_type=(v)
        @compliance_type = v if v && !v.empty?
      end

      # @param v [String]
      def selected_titles=(v)
        # handle absent negative value in API
        v = 'no' if v.empty?
        @selected_titles = v if v && !v.empty?
      end

    end
  end
end