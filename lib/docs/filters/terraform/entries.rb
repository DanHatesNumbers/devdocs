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

        # Remove unneeded Function suffix from function pages because we group them under their own sub-type because there's a lot of them
        name.sub!(/Function\s+/, '')

        # Handle state backends without descriptive names
        if slug_components[:subsubcategory].eql?('backends') &&
           !%w[index configuration].include?(slug_components[:page]) &&
           !slug_components[:subcategory].eql?('state')
          name.prepend 'State Backend - '
        end

        name
      end

      def slug_components
        Hash[%i[category subcategory subsubcategory page].zip slug.split('/')]
      end

      def get_type
        if slug_components[:category].eql?('cli')
          if @@cli_overview_regexs.any? { |exp| exp.match? slug }
            'CLI Features'
          else
            'CLI Commands'
          end
        elsif slug_components[:category].eql?('language')
          if slug_components[:subcategory].eql?('functions')
            'Language - Functions'
          else
            'Language'
          end
        elsif slug_components[:category].eql?('internals')
          'Internals'
        elsif %w[plugin extend].include?(slug_components[:category])
          if %w[how-terraform-works hashicorp-provider-design-principles which-sdk].include?(slug_components[:subcategory])
            'Extending Terraform'
          elsif slug_components[:category].eql?('plugin')
            'Extending Terraform - SDKv2'
          else
            'Extending Terraform - Plugin Framework'
          end
        elsif slug_components[:category].eql?('registry')
          'Registry'
        else
          'Unknown'
        end
      end
    end
  end
end
