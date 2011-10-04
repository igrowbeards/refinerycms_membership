# To use within a controller:
# Place 'require "member_methods"' at the top
# Then, after class name declaration,
# Place 'include MemberMethods'

module MemberMethods
	# Get the id of the current page
	def current_page_id
		url = request.fullpath
		action = ActionController::Routing::Routes.recognize_path(url)
		id = false
		Page.all.each do |page|
		  if page.slug["name"] == action
			id = page.id
			break
		  end
		end
		return id
	end

	# Is this page members only?
	def members_only?
		!PagesRoles.where(:page_id => current_page_id).empty?
	end


	# Is current user an admin?
	def is_admin?
		!(current_user.role_ids & [REFINERY_ROLE_ID, SUPERUSER_ROLE_ID]).empty?
	end
end
