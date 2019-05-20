require 'rails_helper'

describe OogiriEventMailer, type: :mailer do

  let(:oogiri_event) {
    FactoryBot.create(:oogiri_event, title: 'メイラーSpecを書く', description: '送信したメールの内容を確認します')
  }

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
    part.body.raw_source
  end

  describe '#creation_email' do
    let(:mail) { OogiriEventMailer.creation_email(oogiri_event) }

    it '想定通りのメールが生成されている' do
      # ヘッダ
      expect(mail.subject).to eq('新規イベント登録完了のお知らせ')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['oogiri_event@example.com'])

      # Text形式の本文
      expect(text_body).to match('以下のイベントを新規登録しました。')
      expect(text_body).to match('メイラーSpecを書く')
      expect(text_body).to match('送信したメールの内容を確認します')

      # HTML形式の本文
      expect(html_body).to match('以下のイベントを新規登録しました。')
      expect(html_body).to match('メイラーSpecを書く')
      expect(html_body).to match('送信したメールの内容を確認します')
    end
  end
end
