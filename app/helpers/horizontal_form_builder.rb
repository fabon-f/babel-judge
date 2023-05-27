# frozen_string_literal: true

class HorizontalFormBuilder < ActionView::Helpers::FormBuilder
  %i[text_field email_field password_field].each do |name|
    define_method name do |method, options = {}|
      return super(method, options) unless error_field?(method)

      classnames = "#{options[:class] || ''} border-2 border-red-600".strip
      super(method, options.merge({ class: classnames }))
    end
  end

  def label(method, text = nil, options = {}, &block)
    label_class = 'sm:w-1/3 sm:px-4 sm:flex sm:justify-end sm:items-center'
    classnames = "#{options[:class] || ''} #{label_class}".strip
    super(method, text, options.merge({ class: classnames }), &block)
  end

  def error_message(method)
    return unless error_field?(method)

    @template.tag.ul(class: 'text-red-600') do |tag|
      @object.errors.full_messages_for(method).each do |message|
        @template.concat(tag.li(message))
      end
    end
  end

  private

  def error_field?(method)
    return false if @object.nil?

    @object.errors[method].present?
  end
end
