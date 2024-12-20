defmodule Catalyst.Navbar do
  use Phoenix.Component

  @moduledoc ~S"""

  ## Examples

  ### Basic example

  Use the Navbar, NavbarSection and NavbarItem components to build a basic navbar with navigation links:

      <.navbar>
        <.navbar_section>
          <.navbar_item>Home</.navbar_item>
          <.navbar_item>About</.navbar_item>
          <.navbar_item>Contact</.navbar_item>
        </.navbar_section>
      <./navbar>

  The NavbarItem component can be used either as a Link by providing an href prop or as a Button by omitting the href prop.

  ## With Logo

  Add your own logo as an image or component at the beginning of your navbar:

      <.navbar>
        <.link href="/" aria-label="Home">
          <.logo />
        </.link>

        <.navbar_section>
          <.navbar_item>
            <.logo />
          </.navbar_item>
        </.navbar_section>
      <./navbar>  

  To best fit the navbar design, we recommend making your logo 40px tall at mobile sizes, and 32px tall at the sm breakpoint above.

  ## With active state

  Use the current prop to specify which NavbarItem is the current navigation item:

      <.navbar>
        <.link href="/" aria-label="Home">
          <.logo />
        </.link>

        <.navbar_section>
          <.navbar_item current>Home</.navbar_item>
          <.navbar_item>About</.navbar_item>
          <.navbar_item>Contact</.navbar_item>
        </.navbar_section>
      <./navbar>

  ## With icon links

      <.navbar>
        <.link href="/" aria-label="Home">
          <.logo />
        </.link>

        <.navbar_spacer />

        <.navbar_section>
          <.navbar_item href="/search">
            <.icon name="hero-magnifying-glass" />
          </.navbar_item>
        </.navbar_section>
      <./navbar>
  """

  attr(:class, :string, default: nil)
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the navbar container")
  slot(:inner_block)

  def navbar(assigns) do
    ~H"""
    <nav class={["flex flex-1 items-center gap-4 py-2.5", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </nav>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the divider")

  def navbar_divider(assigns) do
    ~H"""
    <div aria-hidden="true" class={["h-6 w-px bg-zinc-950/10 dark:bg-white/10", @class]} {@rest}>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block)

  def navbar_section(assigns) do
    ~H"""
    <div class={["flex items-center gap-3", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  def navbar_spacer(assigns) do
    ~H"""
    <div aria-hidden="true" class={["-ml-4 flex-1", @class]} {@rest}></div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:current, :boolean, default: false)
  attr(:href, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block)
  slot(:icon)
  slot(:avatar)

  def navbar_item(%{href: nil} = assigns) do
    ~H"""
    <span class={["relative", @class]}>
      <button class={navbar_item_classes()} data-current={@current} {@rest}>
        <div class="touch-target">
          <%= render_slot(@inner_block) %>
        </div>
      </button>
      <%= if @current do %>
        <span class="absolute inset-x-2 -bottom-2.5 h-0.5 rounded-full bg-zinc-950 dark:bg-white">
        </span>
      <% end %>
    </span>
    """
  end

  def navbar_item(assigns) do
    ~H"""
    <span class={["relative", @class]}>
      <.link href={@href} class={navbar_item_classes()} data-current={@current} {@rest}>
        <div class="touch-target">
          <%= render_slot(@inner_block) %>
        </div>
      </.link>
      <%= if @current do %>
        <span class="absolute inset-x-2 -bottom-2.5 h-0.5 rounded-full bg-zinc-950 dark:bg-white">
        </span>
      <% end %>
    </span>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block)

  def navbar_label(assigns) do
    ~H"""
    <span class={["truncate", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end

  defp navbar_item_classes do
    [
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
  end
end
