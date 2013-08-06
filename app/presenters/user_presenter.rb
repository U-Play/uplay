class UserPresenter < RailsPresenter::Base
  present :sport_experiences do
    includes :tournaments, :sport, :sport_role
  end

  def nil_formatter
    nil
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def twitter
    if twitter_handle.present?
      h.link_to '', "http://twitter.com/#{twitter_handle}", class: "icon-twitter", target: '_blank'
    end
  end

  def facebook
    if facebook_link.present?
      h.link_to '', facebook_link, class: "icon-facebook", target: '_blank'
    end
  end

  def new_sport_experience
    target.sport_experiences.build
  end

  def referral_url
    h.referral_url(token)
  end
end
