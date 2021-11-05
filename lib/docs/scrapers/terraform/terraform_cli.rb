module Docs
  class TerraformCli < Terraform
    self.name = 'Terraform'
    self.base_url = 'https://terraform.io/docs/cli'
    self.root_path = 'index.html'

    html_filters.insert_before('terraform/clean_html', 'terraform/cli_entries')
  end
end
