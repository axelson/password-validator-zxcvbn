defmodule PasswordValidatorZxcvbn.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :password_validator_zxcvbn,
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:password_validator, "~> 0.4"},
      {:zxcvbn, "~> 0.1.3"}
    ]
  end
end
