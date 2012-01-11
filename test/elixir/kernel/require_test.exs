Code.require_file "../../test_helper", __FILE__

defmodule Kernel::MessedBitwise do
  defmacro bnot(x),   do: x
  defmacro bor(x, _), do: x
end

defmodule Kernel::RequireTest do
  use ExUnit::Case

  require Bitwise, import: true

  def test_import_true do
    1  = band(1, 1)
    1  = bor(0, 1)
    -1 = bnot(0)
  end

  def test_function_import_with_only do
    require Bitwise, except: [bnot: 1]
    require Kernel::MessedBitwise, only: [bnot: 1]
    0 = bnot(0)
    1 = bor(0, 1)
  end

  # This test is asserting that the requires done
  # inside the function do not affect outer ones.
  def test_import_true_not_affected do
    1  = band(1, 1)
    1  = bor(0, 1)
    -1 = bnot(0)
  end

  def test_require_erlang do
    require Erlang.lists, as: MyList
    [1,2,3] = MyList.flatten([1,[2],3])
  end
end