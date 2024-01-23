# frozen_string_literal: true

def pending_spec(description)
  called_from = caller.first.gsub(/#{ROOT}/, ".")
  skip(description + "\n     # #{called_from}")
end

alias pending pending_spec
alias pending_context pending_spec
alias pcontext pending_spec
alias pending_describe pending_spec
alias pdescribe pending_spec
