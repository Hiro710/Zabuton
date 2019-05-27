# 通常のテストデータ
=begin
User.create!(
  name: 'admin',
  email: 'admin@example.com',
  admin: true,
  password: 'password',
  password_confirmation: 'password'
)
=end

# 指定のメールアドレスのレコードが存在するか調べて、存在しない時だけUserレコードを登録する
# find_or_create_by!メソッドは引数に渡した属性で検索を行い、レコードが見つかればそれを返し、
# 見つからなければ新たにレコードを作成する。
# 検索に用いる属性と登録に用いる属性が異なる為、差分をブロック(do〜end)で指定している。
User.find_or_create_by!(email: 'admin@example.com') do | user |
  user.name = 'admin'
  user.admin = true
  user.password = 'password'
  user.password_confirmation = 'password'
end
