module Lesswrong
  class BasePage < Gless::BasePage
    # user_div iff !login_div
    element :user_div,  :div, id: 'side-user', child: :logout, validator: false  #FIXME: duplicate ids when viewing other user logged in; workaround by restricting by child.
    element :login_div, :div, id: 'side-login', validator: false

    # Logged in
    userlink_regexp = %r{^/user/(.*)}
    element :userlink,              :link, href: userlink_regexp, parent: :user_div, validator: false
    element :logout_button,         :link, href: %r{/logout/?$}, click_destination: :HomePage, validator: false
    element :admin_toggle_button,   :link, href: %r{/admino(n|ff)/?$}, validator: false

    element :create_article_button, :link, href: %r{/submit/?$}, click_destination: :WriteArticlePage, validator: false

    # Not logged in
    element :username,        :text_field, id: 'username', validator: false
    element :password,        :text_field, id: 'password', validator: false
    element :login_button,    :button,     type: 'submit', text: 'Login', parent: :login_div, validator: false
    element :register_link,   :link,       text: 'Register', validator: false
    element :user_reg,        :text_field, id: 'user_reg', validator: false, cache: false
    element :password_reg,    :text_field, id: 'passwd_reg', validator: false, cache: false
    element :password2_reg,   :text_field, id: 'passwd2_reg', validator: false, cache: false
    element :register_button, :button,     text: 'Create account', validator: false, cache: false
    element :reg_popup,       :div,        id: 'loginpopup', validator: false, cache: false
    element :reg_close ,      :link,       text: 'Close this window', validator: false, cache: false

    # @return [String, NilClass] The username if logged in; nil otherwise.
    def logged_in_as
      (login_div.exists?) ? nil : userlink.text[userlink_regexp]
    end

    # @return [Boolean] Whether the user is currently logged in.  Approximate
    #   alias of +logged_in_as+.
    def logged_in?
      !!logged_in_as
    end

    # Log out.  If +check+, ensure that the user is logged out by checking
    # whether the user is already logged out.
    def logout check = true
      logout_button.click unless check && !logged_in?
    end

    # Log in using the given credentials, logging out as necessary unless
    # the +check+ argument is false.
    def login username, password, check = true
      if !check || logged_in_as != username
        logout if check && (logged_in?) && logged_in_as != username
        self.username.set username
        self.password.set password
        login_button.click
      end
    end

    # Register, setting the password to the username, skipping if already
    # signed in to the username provided.  If registration fails, emit a
    # warning if +warn_already_registered+ is true and attempt to log in instead.
    def register username, warn_already_registered = true
      return if logged_in_as == username
      logout true

      register_link.click
      user_reg.set username
      password_reg.set username
      password2_reg.set username
      register_button.click
      reg_close.wait_while_present 10

      if reg_popup_open?
        @session.log.warn "register: registration failed.  Trying to log in before failing..." if warn_already_registered

        reg_close.click

        login username, username, true

        if reg_popup_open?
          raise 'register: Could not register user or log in'
        else
          @session.log.warn "register: Successfuly logged in." if warn_already_registered
        end
      end
    end

    def reg_popup_open?
      reg_popup.exists? and reg_popup.style !~ /\bdisplay:\s*none(;|\b)/
    end

    # Toggle admin, or set to +override+ if non-nil.
    def toggle_admin override = nil
      admin_toggle_button.click if override.nil? || admin_on? != override
    end

    def has_admin?
      admin_toggle_button.exists?
    end

    def admin_on?
      has_admin? && !!(admin_toggle_button.href =~ /off/)
    end
  end
end
