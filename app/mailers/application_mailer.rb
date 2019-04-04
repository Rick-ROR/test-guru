class ApplicationMailer < ActionMailer::Base
  default from: %{"TestGuru" <guru@example.edu>}
  layout 'mailer'
end
