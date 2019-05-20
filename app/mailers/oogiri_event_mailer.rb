class OogiriEventMailer < ApplicationMailer
  # 送信者をデフォルト指定
  default from: 'oogiri_event@example.com'

  def creation_email(oogiri_event)
    @oogiri_event = oogiri_event
    mail(
      subject: '新規イベント登録完了のお知らせ',
      to: 'user@example.com',
      from: 'oogiri_event@example.com'
    )
  end
end
