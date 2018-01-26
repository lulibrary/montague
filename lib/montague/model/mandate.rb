module Montague
  module Model

    # Funder compliance mandate
    #
    class Mandate < Montague::Model::Structure

      # @return [Montague::Model::Funder, nil]
      attr_reader :funder

      # @return [String, nil]
      attr_reader :publisher_complies

      # @return [String, nil]
      attr_reader :compliance_type

      # @return [String, nil]
      attr_reader :selected_titles

      # @param v [String]
      def funder=(v)
        @funder = v if v && v.data?
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