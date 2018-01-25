module Montague
  module Model

    # Paid access
    #
    class PaidAccess < Montague::Model::Structure

      # @return [String, nil]
      attr_reader :url

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :notes

      # @param v [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

      # @param v [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param v [String]
      def notes=(v)
        @notes = v if v && !v.empty?
      end

    end
  end
end