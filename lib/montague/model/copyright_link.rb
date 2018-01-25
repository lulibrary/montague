module Montague
  module Model

    # Copyright link
    #
    class CopyrightLink < Montague::Model::Structure

      # @return [String, nil]
      attr_reader :text

      # @return [String, nil]
      attr_reader :url

      # @param v [String]
      def text=(v)
        @text = v if v && !v.empty?
      end

      # @param v [String]
      def url=(v)
        @url = v if v && !v.empty?
      end

    end
  end
end