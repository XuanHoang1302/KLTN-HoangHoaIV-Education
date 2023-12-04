# frozen_string_literal: true

class Breadcrumbs::Trail
  def initialize(home)
    @breadcrumbs = [home]
  end

  def show?
    @breadcrumbs.count > 1
  end

  def back_link
    # Second to last item
    @breadcrumbs[@breadcrumbs.count - 2]
  end

  def tail
    @breadcrumbs.shift(@breadcrumbs.size - 1)
  end

  def head
    @breadcrumbs.last
  end

  def method_missing(method, *args)
    @breadcrumbs.send(method, *args)
  end
end
