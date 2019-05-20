class OogiriEventsController < ApplicationController
  # フィルタを使って重複(ここではshow, edit, update, destroy)を避ける
  before_action :set_oogirievent, only: [ :show, :edit, :update, :destroy ]

  def index
    # 名称による検索
    @q = current_user.oogiri_events.ransack(params[:q])
    @oogiri_events = @q.result(distict: true)
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
    redirect_to oogiri_events_url, notice: "イベント「#{@oogiri_event.title}」を削除しました。"
  end

  # 確認画面を表示するアクション
  def confirm_new
    @oogiri_event = current_user.oogiri_events.new(oogiri_event_params)
    render :new unless @oogiri_event.valid?
  end


  private

  def oogiri_event_params
    params.require(:oogiri_event).permit(:title, :description)
  end

  def set_oogirievent
    @oogiri_event = current_user.oogiri_events.find(params[:id])
  end
end
