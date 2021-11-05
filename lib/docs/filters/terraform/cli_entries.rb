module Docs
  class Terraform
    class CliEntriesFilter < Docs::EntriesFilter
      @@overview_regexs = [
        /index$/,
        /^import\/(?!import$)/,
        /^state/,
        /^plugins/,
        /^config/
      ]

      def get_name
        name ||= at_css('#inner h1').content
        name.delete! '»'
        name.strip!
        name
      end

      def get_type
        if @@overview_regexs.any? { |exp| exp.match? slug }
          'CLI Features'
        else
          'CLI Commands'
        end
      end
    end
  end
end
