# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
# アセットのバージョンを文字列で設定。この値はアセットに付与するダイジェストの生成に関わるので、変更することで
# 全てのアセットを強制的に期限切れにすることができる
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
# アセットの探索パス設定(初期状態ではYarnというパッケージマネージャ用のディレクトリが追加されている)
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# プリコンパイルするファイルを配列で設定。application.js,application.css,app/aseets配下のjs,css以外の全てのファイル
# がデフォルトで対象になっているのでそれ以外のファイルをプリコンパイルの対象にしたい時に利用。
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
