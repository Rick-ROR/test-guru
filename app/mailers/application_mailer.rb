class ApplicationMailer < ActionMailer::Base
  default from: %{"TestGuru" <Rick.ROR@ya.ru>}
  layout 'mailer'
end
