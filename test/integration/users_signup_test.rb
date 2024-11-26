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
    follow_redirect!
    assert_template 'users/show'
    # ステータスコードが422（Unprocessable Entity）であることを確認
    assert_response :unprocessable_entity
    # エラーが発生した際に表示されるテンプレートが `users/new` であることを確認
    assert_template 'users/new'
    # エラー表示用のCSSセレクタが正しいことを確認
    assert_select 'div#error_explanation'
    # エラーに関連するCSSクラス（例: `field_with_errors`）が存在することを確認
    assert_select 'div.field_with_errors'
  end
end
