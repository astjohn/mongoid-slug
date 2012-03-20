module Mongoid
  module Slug
    module Embedded
      extend ActiveSupport::Concern

      included do
        alias_method_chain :find, :slug
      end

      def find_with_slug(*args)
        find_without_slug(*args)
      rescue BSON::InvalidObjectId
        find_by_slug = :"find_by_#{klass.slug_name}"
        respond_to?(find_by_slug) ? send(find_by_slug, *args) : raise
      end
    end
  end
end

class Mongoid::Relations::Embedded::Many < Mongoid::Relations::Many
  include Mongoid::Slug::Embedded
end
