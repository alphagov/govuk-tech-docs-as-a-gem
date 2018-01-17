require 'tech_docs_gem/version'

require 'middleman'
require 'middleman-autoprefixer'
require 'middleman-sprockets'
require 'middleman-syntax'

require 'tech_docs_gem/unique_identifier_generator'
require 'tech_docs_gem/unique_identifier_extension'
require 'tech_docs_gem/tech_docs_html_renderer'

require 'table_of_contents/heading'
require 'table_of_contents/headings_builder'
require 'table_of_contents/heading_tree'
require 'table_of_contents/heading_tree_builder'
require 'table_of_contents/heading_tree_renderer'

module TechDocs
  def self.load(context)
    context.activate :autoprefixer
    context.activate :sprockets
    context.activate :syntax

    context.files.watch :source, path: 'tech_docs_gem/lib/extra_source'

    context.after_configuration do
      sprockets.append_path 'tech_docs_gem/lib/assets/javascripts'
    end
  end
end

class TechDocsExtension < Middleman::Extension
  def after_configuration
    ::Sass.load_paths.concat(["#{__dir__}/assets/stylesheets"])

    @app.set :markdown_engine, :redcarpet
    @app.set :markdown,
        renderer: TechDocsHTMLRenderer.new(
          with_toc_data: true
        ),
        fenced_code_blocks: true,
        tables: true,
        no_intra_emphasis: true

    # Reload the browser automatically whenever files change
    @app.configure :development do
      activate :livereload
    end

    @app.configure :build do
      activate :minify_css
      activate :minify_javascript
    end

    @app.config[:tech_docs] = YAML.load_file('config/tech-docs.yml').with_indifferent_access
    @app.activate :unique_identifier
  end

  helpers do
    require 'table_of_contents/helpers'
    include TableOfContents::Helpers
  end
end

::Middleman::Extensions.register(:tech_docs, TechDocsExtension)
