module Docs
  class Terraform
    class CleanHtmlFilter < Filter
      def call
        @doc = at_css('#inner')

        css('hr', 'a.anchor').remove

        css('.alert').each do |node|
          node.name = 'blockquote'
        end

        css('pre').each do |node|
          if language = node['class'][/(json|shell|ruby|hcl)/, 1]
            node['data-language'] = language
          end
          node.content = node.content
          node.remove_attribute('class')
        end

        css('.highlight').each do |node|
          node.before(node.children).remove
        end

        doc
      end
    end
  end
end
