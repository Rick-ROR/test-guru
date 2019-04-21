class SenderToAdminsMailer < ApplicationMailer

  def send_mails(admin_emails, email_anon, subject, body)

    @body = body

    mail to: admin_emails,
         reply_to: email_anon,
         subject: subject
  end
end
