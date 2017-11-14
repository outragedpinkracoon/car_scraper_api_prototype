require 'net/http'
require 'nokogiri'
require 'open-uri'

module Scraping
  module ArnoldClark
    class CarsRequest
      extend Callable

      def initialize(car_index)
        @car_index = car_index
      end

      def call
        {
          html_document: request_car_page,
          href: car_href
        }
      end

      def cache_key
        raise NotImplementedError 'you must provide a cache key'
      end

      private

      attr_reader :car_index

      def request_car_page
        @car_page ||= Nokogiri::HTML(
          open(
            car_href
          )
        )
      end

      def car_href
        path = car_html.css('.ac-vehicle__title a')[0]['href']
        "https://www.arnoldclark.com#{path}"
      end

      def car_html
        index_page.css('.ac-result')[car_index]
      end

      def index_page
        cached = Rails.cache.read cache_key
        return Nokogiri::HTML(cached) if cached

        result = Nokogiri::HTML(open(url))
        Rails.cache.write cache_key, result.to_s
        result
      end
    end
  end
end
