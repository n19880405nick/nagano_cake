class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	


	# 管理者、顧客それぞれのログイン後の表示画面変更
	def after_sign_in_path_for(resource_or_scope)
		if resource_or_scope.is_a?(Admin)
	  	admin_top_path
		else
		  root_path
		end
	end
	
	# 管理者、顧客それぞれのログアウト後の表示画面変更
  def after_sign_out_path_for(resource_or_scope)
		if resource_or_scope == :admin
		  admin_session_path
		else
		  root_path
		end
  end
	
	protected
	
	def configure_permitted_parameters
	   devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
	   :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
	end
end
