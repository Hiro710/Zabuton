class OogiriEventsController < ApplicationController
  # フィルタを使って重複(ここではshow, edit, update, destroy)を避ける
  before_action :set_oogirievent, only: [ :show, :edit, :update, :destroy ]

  def index
    # 名称による検索
    @q = current_user.oogiri_events.ransack(params[:q])
    # ページ番号に対応するデータの範囲を検索する(kaminariのpageスコープを使う)、per(30)で30件まで表示
    @oogiri_events = @q.result(distict: true).page(params[:page]).per(30)

    # CSV出力実装部分
    respond_to do |format|
      format.html
      format.csv {
        send_data @oogiri_events.generate_csv, filename: "oogiri_events-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
      }
    end
  end

  def import
    current_user.oogiri_events.import(params[:file])
    redirect_to oogiri_events_url, notice: "イベントを追加しました"
  end

  def show
  end

  def new
    @oogiri_event = OogiriEvent.new
  end

  def create
    @oogiri_event = current_user.oogiri_events.new(oogiri_event_params)

    # params[:back]で"戻る"という文字列を得て、「戻る」ボタンが押されたら現在の入力内容を保持したまま
    # 新規イベント登録入力フォームを表示する。「登録」ボタンが押されたら受け取ったパラメータを元に登録して
    # 一覧画面に戻る
    if params[:back].present?
      render :new
      return
    end

    if @oogiri_event.save
      # デバッグ用にログ出力させたい場合
      # logger.debug "イベント： #{@oogiri_event.attributes.inspect}"

      # イベント新規登録後にメールを送信する
      OogiriEventMailer.creation_email(@oogiri_event).deliver_now
      # ジョブの呼び出し
      # 日時指定してジョブ実行(例：翌日の正午にジョブ実行する場合)
      # SampleJob.set(wait_until: Date.tomorrow.noon).perform_later
      # 一週間後にジョブ実行 SampleJob.set(wait:1.week).perform_later
      # SampleJob.perform_later
      redirect_to @oogiri_event, notice: "イベント「#{@oogiri_event.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @oogiri_event.update!(oogiri_event_params)
    redirect_to oogiri_events_url, notice: "イベント「#{@oogiri_event.title}」を更新しました。"
  end

  def destroy
    @oogiri_event.destroy
    # Ajaxリクエストを受け取ってイベントの削除を行う
    # head :no_content
  end

=begin
  # 確認画面を表示するアクション
  def confirm_new
    @oogiri_event = current_user.oogiri_events.new(oogiri_event_params)
    render :new unless @oogiri_event.valid?
  end
=end

  private
  # Strong Parameters(許可するパラメータのキーを指定)
  def oogiri_event_params
    params.require(:oogiri_event).permit(:title, :description, :image)
  end

  def set_oogirievent
    @oogiri_event = current_user.oogiri_events.find(params[:id])
  end
end
