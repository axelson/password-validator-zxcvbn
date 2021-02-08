defmodule PasswordValidatorZxcvbn.MixProject do
  use Mix.Project

  @app :password_validator_zxcvbn
  @version "0.1.0"

  def project do
    [
      app: @app,
      version: @version,
      description: description(),
      package: package(),
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Password Validator ZXCVBN",
      docs: [
        main: "PasswordValidator.Validators.ZXCVBNValidator",
        canonical: "https://hexdocs.pm/password_validator_zxcvbn"
      ],
      source_url: "https://github.com/axelson/password-validator-zxcvbn",
      homepage_url: "https://github.com/axelson/password-validator-zxcvbn"
    ]
  end

  def package do
    [
      name: @app,
      files: ["lib", "mix.exs", "README*", "LICENSE*", "Changelog.md"],
      maintainers: ["Jason Axelson"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/axelson/password-validator-zxcvbn"}
    ]
  end

  def description do
    """
    A library to validate passwords, with built-in validators for password
    length as well as the character sets used. Custom validators can also be
    created.
    """
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
      {:docception, github: "evnu/docception"},
      {:zxcvbn, "~> 0.1.3"}
    ]
  end
end
