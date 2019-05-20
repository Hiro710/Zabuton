# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
# アプリケーションログに特定のパラメータ値を出力しないようにする(セキュアな情報が含まれている場合)
# デフォルトでpasswordが設定されている
Rails.application.config.filter_parameters += [:password]
