require PhoenixStorybook

Application.put_env(
  :catalyst,
  :secret_key_base,
  "Hu4qQN3iKzTV4fJxhorPQlA/osH9fAMtbtjVS58PFgfw3ja5Z18Q/WSNR9wP4OfW"
)

defmodule Catalyst.Storybook do
  use PhoenixStorybook,
    otp_app: :catalyst,
    content_path: Path.expand("./storybook", __DIR__),
    # assets path are remote path, not local file-system paths
    css_path: "/assets/my_components.css",
    js_path: "/assets/my_components.js"
end

defmodule Catalyst.StorybookRouter do
  use Phoenix.Router
  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_root_layout, html: {PhoenixPlayground.Layout, :root}
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :browser

    live_storybook("/", backend_module: Catalyst.Storybook, pipeline: false)
  end
end

PhoenixPlayground.start(plug: Catalyst.StorybookRouter)
