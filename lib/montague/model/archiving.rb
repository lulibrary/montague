module Montague
  module Model

    # Archiving
    #
    class Archiving < Montague::Model::Structure

      # @return [String, nil]
      attr_reader :permission

      # @return [Array<String>]
      attr_reader :restrictions

      # @param v [String]
      def permission=(v)
        @permission = v if v && !v.empty?
      end

      # @param v [Array]
      def restrictions=(v)
        @restrictions = v if v
      end

    end
  end
end