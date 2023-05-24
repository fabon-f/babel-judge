# frozen_string_literal: true

class HorizontalFormRowComponent < ViewComponent::Base
  renders_one :label
  renders_one :field
  renders_one :description
end
