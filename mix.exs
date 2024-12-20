defmodule Catalyst.MixProject do
  use Mix.Project

  def project do
    [
      app: :catalyst,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.7"},
      {:phoenix_live_view, "~> 1.0"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_html_helpers, "~> 1.0"},

      # dev/test dependencies
      {:a11y_audit, "~> 0.2.0", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:phoenix_playground, "~> 0.1.4", only: [:dev, :test]},
      {:phoenix_storybook, "~> 0.7.2", only: [:dev, :test]},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.5",
       app: false,
       compile: false,
       sparse: "optimized",
       only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      storybook: "run storybook.exs"
    ]
  end
end
