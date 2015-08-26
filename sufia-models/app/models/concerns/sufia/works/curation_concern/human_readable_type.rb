module Sufia::Works
  module CurationConcern
    module HumanReadableType
      extend ActiveSupport::Concern

      included do
        class_attribute :human_readable_short_description, :human_readable_type
        self.human_readable_type = name.demodulize.titleize
      end

      def human_readable_type
        self.class.human_readable_type
      end

      # TODO: this should be moved into the indexing service (e.g. GenericWorkIndexingService)
      def to_solr(solr_doc = {})
        super(solr_doc).tap do |doc|
          doc[Solrizer.solr_name('human_readable_type', :facetable)] = human_readable_type
          doc[Solrizer.solr_name('human_readable_type', :stored_searchable)] = human_readable_type
        end
      end
    end
  end
end
