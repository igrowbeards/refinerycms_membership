# To use within a controller:
# Place 'require "member_methods"' at the top
# Then, after class name declaration,
# Place 'include MemberMethods'

module MemberMethods
	def url_format(theString)
		theString.downcase.gsub(/ /, "-")
	end

	# Get the id of the current page
	def current_page_id
		url = request.fullpath[1..-1]
		id = false
		Page.all.each do |page|
		  if url_format(page.title) == url
			id = page.id
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
