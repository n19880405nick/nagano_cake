# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  before_action :customer_state, only: [:create]
  
  protected
  # 退会しているかを判断するメソッド
  def customer_state
    ## 【処理内容１】入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容２】取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別
    if @customer.valid_password?(params[:customer][:password])
      ## 【処理内容３】処理２がtrueかつ退会カラムの真偽にて、行先指定
      if true && params[:is_active] == true
        ## 退会していなかったらログイン画面へ
        redirect_to customer_session_path
      elsif true && params[:is_active] == !true
        ## 退会していたらサインアップ画面へ
        redirect_to new_customer_registration_path
      end
    end
  end
end
