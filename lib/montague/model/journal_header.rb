module Montague
  module Model

    # Journal header
    #
    class JournalHeader < Montague::Model::Structure

      # @return [String, nil]
      attr_reader :issn

      # @return [String, nil]
      attr_reader :title

      # @param v [String]
      def issn=(v)
        @issn = v if v && !v.empty?
      end

      # @param v [String]
      def title=(v)
        @title = v if v && !v.empty?
      end

    end
  end
end