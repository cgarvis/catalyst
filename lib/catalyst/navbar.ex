defmodule Catalyst.Navbar do
  use Phoenix.Component

  attr :class, :string, default: nil
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"
  slot :inner_block

  def navbar(assigns) do
    ~H"""
    <nav class={["flex flex-1 items-center gap-4 py-2.5", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </nav>
    """
  end

  def navbar_divider(assigns) do
    ~H"""
    <div aria-hidden="true" class={["h-6 w-px bg-zinc-950/10 dark:bg-white/10", @class]} {@rest}>
      <!-- empty div -->
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block

  def navbar_section(assigns) do
    ~H"""
    <div class={["flex items-center gap-3", @class]}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def navbar_spacer(assigns) do
    ~H"""
    <div aria-hidden="true" class={["-ml-4 flex-1", @class]}>
      <!-- empty div -->
    </div>
    """
  end

  def navbar_item(assigns, ref: nil) do
    ~H"""
    """
  end

  attr :class, :string, default: nil
  slot :inner_block

  def navbar_label(assigns) do
    ~H"""
    <span class={["truncate", @class]}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end
end
