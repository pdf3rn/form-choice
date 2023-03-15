# frozen_string_literal: true

module FormChoice
  module TagHelper
    cattr_accessor(:id, instance_accessor: false) { 0 }

    def choices_field_tag(name, value = nil, options = {})
      options = options.symbolize_keys
      form = options.delete(:form)

      hidden_field_tag(name, value, id: options[:input], form: form)
    end
  end
end

module ActionView::Helpers

  class Tags::ChoicesField < Tags::Base
    delegate :dom_id, to: ActionView::RecordIdentifier

    def initialize(object_name, method_name, template_object, collection, value_method, text_method, options, html_options)
      @collection = collection
      @value_method = value_method
      @text_method = text_method
      @html_options = html_options

      super(object_name, method_name, template_object, options || {})
    end

    def render
      option_tags_options = {
        selected: @options.fetch(:selected) { value },
        disabled: @options[:disabled]
      }
      @html_options[:class] += ' choices-field'

      select = select_content_tag(
        options_from_collection_for_select(@collection, @value_method, @text_method, option_tags_options),
        @options, @html_options
      )
      content_tag(:div, select, { class: 'choices-field-wrapper', data: { controller: "choices-field" } })
    end

    def options_from_collection_for_select(collection, value_method, text_method, selected = nil)
      options = []
      options << add_placeholder if @html_options[:placeholder]
      selected, disabled = extract_selected_and_disabled(selected).map do |r|
        Array(r).map(&:to_s)
      end
      extras = @options.delete(:extras) || []
      options += collection.map do |element|
        html_attributes = option_html_attributes(element)
        text = value_for_collection(element, text_method).to_s
        value = value_for_collection(element, value_method).to_s

        html_attributes[:selected] ||= option_value_selected?(value, selected)
        html_attributes[:disabled] ||= disabled && option_value_selected?(value, disabled)
        html_attributes[:value] = value
        if extras.size > 0
          html_attributes[:data] ||= {}
          extras.map do |extra|
            html_attributes[:data][extra] = value_for_collection(element, extra).to_s
          end
        end

        tag_builder.content_tag_string(:option, text, html_attributes)
      end
      options.join("\n").html_safe
    end

    def add_placeholder
      text = @html_options.delete(:placeholder)
      tag_builder.content_tag_string(:option, text, { value: "" })
    end
  end

  module FormHelper
    def choices_field(object, method, collection, value_method, text_method, options = {}, html_options = {})
      Tags::ChoicesField.new(object, method, self, collection, value_method, text_method, options, html_options).render
    end
  end

  class FormBuilder
    def choices_field(method, collection, value_method, text_method, options = {}, html_options = {})
      @template.choices_field(@object_name, method, collection, value_method, text_method, objectify_options(options), @default_html_options.merge(html_options))
    end
  end
end
