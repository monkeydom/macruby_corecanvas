require 'test/unit'
require 'corecanvas'

class CanvasTest < Test::Unit::TestCase
  def test_angles
    assert_equal 180.0,
      CoreCanvas.degrees(Math::PI)
  end

end