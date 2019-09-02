defmodule PasswordValidator.ReadmeDoctest do
  @file "#{Path.join([File.cwd!(), "README.md"])}"
  @external_resource @file
  @moduledoc """
  #{File.read!("/home/jason/dev/password_validator_zxcvbn/README.md")}
  """
end
