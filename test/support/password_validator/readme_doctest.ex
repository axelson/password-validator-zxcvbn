defmodule PasswordValidator.ReadmeDoctest do
  @file "#{Path.join([File.cwd!(), "README.md"])}"
  @external_resource @file
  @moduledoc """
  #{File.read!(@file)}
  """
end
