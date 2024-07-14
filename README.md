# PasswordValidatorZxcvbn

This is a custom validator for [https://github.com/axelson/password-validator/](Password Validator) that implements the [https://github.com/dropbox/zxcvbn](zxcvbn) password scoring algorithm via [https://github.com/techgaun/zxcvbn-elixir/](zxcvbn-elixir).

## Installation

Add the following to your `deps` list in `mix.exs`

```elixir
{:password_validator_zxcvbn, "~> 0.2.0"},
```

## Configuration and Usage

```elixir
iex> opts = [
...>   additional_validators: [PasswordValidator.Validators.ZXCVBNValidator],
...>   zxcvbn: [min_score: 4]
...> ]
iex> PasswordValidator.validate_password("password", opts)
{:error, ["This is a top-10 common password"]}
```

## Known Issues

* Only [https://en.wikipedia.org/wiki/ASCII](ASCII) characters are supported
  * Upstream issue: https://github.com/techgaun/zxcvbn-elixir/issues/16
