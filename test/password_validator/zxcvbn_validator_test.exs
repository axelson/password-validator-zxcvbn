defmodule PasswordValidator.Validators.ZXCVBNValidatorTest do
  use ExUnit.Case, async: true
  alias PasswordValidator.Validators.ZXCVBNValidator

  doctest ZXCVBNValidator
  doctest PasswordValidator.ReadmeDoctest

  describe "validation" do
    test "integration with PasswordValidator" do
      opts = [
        additional_validators: [PasswordValidator.Validators.ZXCVBNValidator],
        zxcvbn: [min_score: 4]
      ]

      assert PasswordValidator.validate_password("poor password", opts) ==
               {:error, ["This is similar to a commonly used password"]}
    end
  end

  describe "validate/2" do
    import ZXCVBNValidator, only: [validate: 2]

    test "when disabled returns :ok" do
      assert validate("pass", zxcvbn: :disabled) == :ok
    end

    test "invalid configuration" do
      assert_raise RuntimeError, "ZXCVBN min_score must be between 1 and 4, got -1", fn ->
        validate("a password", zxcvbn: [min_score: -1])
      end
    end

    test "a valid password" do
      assert validate("some given password", zxcvbn: [min_score: 2]) == :ok
    end

    test "a nil password" do
      assert_raise FunctionClauseError, fn ->
        assert validate(nil, []) == :ok
      end
    end

    @tag :pending
    test "emoji password can be valid" do
      password = "🏆🔥 and words"
      assert validate(password, []) == :ok
    end

    test "a weak password" do
      assert validate("one word", zxcvbn: [min_score: 2]) == :ok

      assert validate("one word", zxcvbn: [min_score: 3]) ==
               {:error, ["Add another word or two. Uncommon words are better."]}
    end

    test "a password that matches a user input gets a low score" do
      password = "myrealname"
      assert {:error, _} = validate(password, zxcvbn: [user_inputs: [password], min_score: 1])
      assert validate(password, zxcvbn: [user_inputs: [], min_score: 1]) == :ok
    end

    test "a password that is similar to a user input is penalized" do
      password = "myrealname123"
      assert validate(password, zxcvbn: [user_inputs: ["myrealname"], min_score: 1]) == :ok
      assert {:error, _} = validate(password, zxcvbn: [user_inputs: ["myrealname"], min_score: 2])
      assert validate(password, zxcvbn: [user_inputs: [], min_score: 4]) == :ok
    end
  end

  test "README.md version is up to date" do
    app = :password_validator_zxcvbn
    app_version = Application.spec(app, :vsn) |> to_string()
    readme = File.read!("README.md")
    [_, readme_version] = Regex.run(~r/{:#{app}, "(.+)"}/, readme)
    assert Version.match?(app_version, readme_version)
  end
end
