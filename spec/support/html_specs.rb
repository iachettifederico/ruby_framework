# frozen_string_literal: true

require "nokogiri"
require "rspec-html-matchers"

def HTML(html_string)
  Nokogiri::HTML(html_string)
end

module HtmlMatchers
  def has_tag?(tagname, text: nil, with: {})
    nodes = css(tagname)

    node_exists = !nodes.empty?

    nodes.any? { |node|
      node_has_text?(node, text) &&
        node_has_attributes?(node, with)
    }
  end

  def find_tag(tagname)
    css(tagname).first
  end

  def find_tags(tagname)
    css(tagname)
  end

  private

  def node_has_text?(node, text)
    return true unless text

    node.text == text
  end

  def node_has_attributes?(node, attributes)
    attributes.all? { |attr, value|
      node[attr.to_s] == value
    }
  end
end

[
  Nokogiri::XML::Element,
  Nokogiri::XML::Document,
].each do |node_type|
  node_type.include(HtmlMatchers)
end
