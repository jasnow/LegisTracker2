module ApplicationHelper

  def current_class?(test_path)
    return 'current' if request.fullpath == test_path
    ''
  end

  def current1_class?(test_path)
    return 'current1' if request.full_path == test_path
    ''
  end
end

