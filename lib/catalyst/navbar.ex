defmodule Catalyst.Navbar do
  use Phoenix.Component

  attr(:class, :string, default: nil)
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the flash container")
  slot(:inner_block)

  def navbar(assigns) do
    ~H"""
    <nav class={["flex flex-1 items-center gap-4 py-2.5", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </nav>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the flash container")
  slot(:inner_block)

  def navbar_divider(assigns) do
    ~H"""
    <div aria-hidden="true" class={["h-6 w-px bg-zinc-950/10 dark:bg-white/10", @class]} {@rest}>
      <!-- empty div -->
    </div>
    """
  end

  attr(:class, :string, default: nil)
  slot(:inner_block)

  def navbar_section(assigns) do
    ~H"""
    <div class={["flex items-center gap-3", @class]}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)

  def navbar_spacer(assigns) do
    ~H"""
    <div aria-hidden="true" class={["-ml-4 flex-1", @class]}>
      <!-- empty div -->
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr :current, :boolean, default: false
  slot(:inner_block)

  def navbar_item(assigns) do
    classes = [
      # Base
      "relative flex min-w-0 items-center gap-3 rounded-lg p-2 text-left text-base/6 font-medium text-zinc-950 sm:text-sm/5",
      # Leading icon/icon-only
      "data-[slot=icon]:*:size-6 data-[slot=icon]:*:shrink-0 data-[slot=icon]:*:fill-zinc-500 sm:data-[slot=icon]:*:size-5",
      # Trailing icon (down chevron or similar)
      "data-[slot=icon]:last:[&:not(:nth-child(2))]:*:ml-auto data-[slot=icon]:last:[&:not(:nth-child(2))]:*:size-5 sm:data-[slot=icon]:last:[&:not(:nth-child(2))]:*:size-4",
      # Avatar
      "data-[slot=avatar]:*:-m-0.5 data-[slot=avatar]:*:size-7 data-[slot=avatar]:*:[--avatar-radius:theme(borderRadius.DEFAULT)] data-[slot=avatar]:*:[--ring-opacity:10%] sm:data-[slot=avatar]:*:size-6",
      # Hover
      "data-[hover]:bg-zinc-950/5 data-[slot=icon]:*:data-[hover]:fill-zinc-950",
      # Active
      "data-[active]:bg-zinc-950/5 data-[slot=icon]:*:data-[active]:fill-zinc-950",
      # Dark mode
      "dark:text-white dark:data-[slot=icon]:*:fill-zinc-400",
      "dark:data-[hover]:bg-white/5 dark:data-[slot=icon]:*:data-[hover]:fill-white",
      "dark:data-[active]:bg-white/5 dark:data-[slot=icon]:*:data-[active]:fill-white"
    ]

    ~H"""
    <span class={["relative", @class]}>
      <.link class={classes} data-current={@current}>
        <%= render_slot(@inner_block) %>
      </.link>
    </span>
    """
  end

  attr(:class, :string, default: nil)
  slot(:inner_block)

  def navbar_label(assigns) do
    ~H"""
    <span class={["truncate", @class]}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end
end

