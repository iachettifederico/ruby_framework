# frozen_string_literal: true

module Forms
  class ExampleForm
    include Phlex::HtmlRenderable
    include Forms::Form

    def template
      h1(class: "text-slate-800 font-semibold text-xl") { "HTML Form Example" }

      field_wrapper do
        label(:username)
        text_field(:username, value: "snth")
      end

      field_wrapper do
        label(:color_field)
        color_field(:color_field)
      end

      field_wrapper do
        label(:date_field)
        date_field(:date_field)
      end

      field_wrapper do
        label(:datetime_local_field)
        datetime_local_field(:datetime_local_field)
      end

      field_wrapper do
        label(:email_field)
        email_field(:email_field)
      end

      field_wrapper do
        label(:hidden_field)
        hidden_field(:hidden_field)
      end

      field_wrapper do
        label(:label)
        label(:label)
      end

      field_wrapper do
        label(:number_field)
        number_field(:number_field)
      end

      field_wrapper do
        label(:password_field)
        password_field(:password_field)
      end

      field_wrapper do
        label(:search_field)
        search_field(:search_field)
      end

      field_wrapper do
        label(:select)
        select(:select, options: [
                 %w[text value]
               ])
      end

      field_wrapper do
        label(:text_field)
        text_field(:text_field)
      end

      input(type: "submit", class: "py-1 px-2 text-slate-50 bg-slate-800 border border-1 border-slate-800 hover:bg-slate-700 rounded") { "send" }
    end

    private

    def field_wrapper(&)
      div(class: "flex items-center gap-1", &)
    end

    def default_classes
      %w[p-4 m-2 bg-slate-50 border border-2 border-slate-300 rounded-lg]
    end
  end
end
