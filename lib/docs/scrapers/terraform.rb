module Docs
  class Terraform < UrlScraper
    self.name = 'Terraform'
    self.type = 'terraform'
    self.base_url = 'https://www.terraform.io/docs/'
    self.release = '1.0.9'
    self.root_path = 'index.html'
    self.links = {
      home: 'https://www.terraform.io/',
      code: 'https://github.com/hashicorp/terraform'
    }

    html_filters.push 'terraform/entries', 'terraform/clean_html'

    options[:skip_patterns] = [/enterprise/, /enterprise-legacy/]

    options[:attribution] = <<-HTML
      &copy; 2021 HashiCorp</br>
      Licensed under the MPL 2.0 License.
    HTML

    def get_latest_version(opts)
      contents = get_github_file_contents('hashicorp', 'terraform-website', 'content/config.rb', opts)
      contents.scan(/version\s+=\s+"([0-9.]+)"/)[0][0]
    end
  end
end
