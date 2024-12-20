defmodule Catalyst.Alert do
  use Phoenix.Component

  @moduledoc """
  Attention-grabbing messages for user notifications.

  ## Examples

      <.alert title="The requested file is ready to download." />

  ### Variants

      <.alert title="Important update: Please read carefully" />
      <.alert variant="neutral" title="System maintenance scheduled for tonight" />
      <.alert variant="error" title="Critical error. Unable to process request" />
      <.alert variant="warning" title="Low disk space. Action required soon" />
      <.alert variant="success" title="Payment successfully processed. Thank you!" />
      <.alert variant="info" title="New feature available. Check it out!" />

  ### Subtitle

      <.alert title="Yeeey!" subtitle="Your profile picture has been updated." />

  ### Content

      <.alert title="Update Available!">
        <p>A new version of the application is available. Would you like to update now?</p>

        <div class="mt-4 flex space-x-2">
          <.button size="xs">Update Now</.button>
          <.button size="xs" variant="ghost">Remind Me Later</.button>
        </div>
      </.alert>

  ### Icon

      <.alert title="Bitcoin price alert: Significant market movement">
        <:icon>
          <.icon name="hero-currency-dollar" class="size-5 text-amber-500" />
        </:icon>
      </.alert>

      <.alert hide_icon title="Bitcoin price alert: Significant market movement" />
  """

  attr :variant, :string, default: "default", values: ~w(default success error warning info)
  attr :title, :string, default: nil
  attr :subtitle, :string, default: nil
  attr :class, :string, default: nil
  attr :rest, :global

  slot :icon
  slot :inner_block, required: true

  def alert(assigns) do
    ~H"""
    <div
      class={[
        "flex items-start gap-3 rounded-md px-4 py-3 text-sm",
        alert_colors(@variant),
        @class
      ]}
      {@rest}
    >
      <%= if @icon != [] do %>
        <div class="flex-shrink-0 mt-0.5">
          <%= render_slot(@icon) %>
        </div>
      <% end %>

      <div class="flex-1">
        <%= if @title do %>
          <div class="font-medium"><%= @title %></div>
        <% end %>
        <%= if @subtitle do %>
          <div class="text-sm opacity-90"><%= @subtitle %></div>
        <% end %>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  # Pattern match on different alert variants to apply appropriate colors
  defp alert_colors("success"),
    do: "bg-green-50 text-green-700 dark:bg-green-950 dark:text-green-300"

  defp alert_colors("error"), do: "bg-red-50 text-red-700 dark:bg-red-950 dark:text-red-300"

  defp alert_colors("warning"),
    do: "bg-yellow-50 text-yellow-700 dark:bg-yellow-950 dark:text-yellow-300"

  defp alert_colors("info"), do: "bg-blue-50 text-blue-700 dark:bg-blue-950 dark:text-blue-300"
  defp alert_colors("default"), do: "bg-gray-50 text-gray-700 dark:bg-gray-950 dark:text-gray-300"
end
