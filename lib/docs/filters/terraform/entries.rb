module Docs
  class Terraform
    class EntriesFilter < Docs::EntriesFilter
      @@cli_overview_regexs = [
        /^cli.*index$/,
        /^cli\/import\/(?!import$)/,
        /^cli\/state/,
        /^cli\/plugins/,
        /^cli\/config/
      ]

      def get_name
        name ||= at_css('#inner h1').content
        name.delete! '»'
        name.sub!(/Function\s+/, '')
        name.strip!
        name
      end

      def get_type
        category, subcategory, = *slug.split('/')
        if category.eql?('cli')
          if @@cli_overview_regexs.any? { |exp| exp.match? slug }
            'CLI Features'
          else
            'CLI Commands'
          end
        elsif category.eql?('language')
          if subcategory.eql? 'functions'
            'Language - Functions'
          else
            'Language'
          end
        else
          'Unknown'
        end
      end
    end
  end
end
