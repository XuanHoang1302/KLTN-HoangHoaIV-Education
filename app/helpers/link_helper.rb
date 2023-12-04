# frozen_string_literal: true

module LinkHelper
  # The `active_link?` checks whether the passed link is currently considered
  # active. There are three strategies to check for;
  # - inclusive; returns true for child routes too
  # - exclusive (default); returns true for exact route without parameters
  # - exact; returns true for exact matches including parameters
  # - regex; returns true when the regex and the route matches
  # @returns [Boolean] Whether a link is considered active
  def active_link?(original_url, strategy: :exclusive)
    url = Addressable::URI.parse(original_url).path
    current_path = request.original_fullpath

    case strategy
    when :inclusive
      # Useful for all routes for a controller (e.g. /requests/*)
      current_path.match(%r{^#{Regexp.escape(url).chomp('/')}(/.*|\?.*)?$}).present?
    when :exclusive
      # Useful for nested routes of a controller (e.g. /requests/new)
      current_path.match(%r{^#{Regexp.escape(url)}/?(\?.*)?$}).present?
    when Regexp
      # Useful for all the dirty matching to your liking.
      current_path.match(strategy).present?
    else
      # Useful for exact matching the paths (e.g. /requests/new?filter=testing)
      current_path == original_url
    end
  end
end
