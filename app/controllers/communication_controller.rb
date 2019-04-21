class CommunicationController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :validate_params, only: %i[feedback_send]

  def feedback;
    @last_body = params[:feedback]
  end

  def feedback_send
    admin_emails = Admin.all.collect(&:email)
    email_anon = params[:email]
    subject = params[:subject]
    body = params[:body]

    if validate_mail(email_anon, subject, body)
      SenderToAdminsMailer.send_mails(admin_emails, email_anon, subject, body).deliver_now
      redirect_to feedback_path, notice: 'Ваш Feedback в пути!'
    else
      redirect_to feedback_path(feedback: body), alert: 'Нужно заполнить все поля!'
    end
  end

  private

  def validate_mail(*params)
    return false unless params.present?

    params.all?(&:present?)
  end
end
