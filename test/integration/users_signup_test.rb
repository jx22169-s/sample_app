require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # follow_redirect! は不要なので削除
    # 'new' テンプレートが再表示されていることを確認
    assert_template 'users/new'
    # ステータスコードが422（Unprocessable Entity）であることを確認
    assert_response :unprocessable_entity
    # エラー表示用のCSSセレクタが正しいことを確認
    assert_select 'div#error_explanation'
    # エラーに関連するCSSクラスが存在することを確認
    assert_select 'div.field_with_errors'
  end
end
