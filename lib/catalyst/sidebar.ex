defmodule Catalyst.Sidebar do
  use Phoenix.Component

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar(assigns) do
    ~H"""
    <nav class={["flex h-full min-h-0 flex-col", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </nav>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar_header(assigns) do
    ~H"""
    <div class={[
      "flex flex-col border-b border-zinc-950/5 p-4 dark:border-white/5 [&>[data-slot=section]+[data-slot=section]]:mt-2.5",
      @class
    ]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar_body(assigns) do
    ~H"""
    <div class={[
      "flex flex-1 flex-col overflow-y-auto p-4 [&>[data-slot=section]+[data-slot=section]]:mt-8",
      @class
    ]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar_footer(assigns) do
    ~H"""
    <div class={[
      "flex flex-col border-t border-zinc-950/5 p-4 dark:border-white/5 [&>[data-slot=section]+[data-slot=section]]:mt-2.5",
      @class
    ]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar_section(assigns) do
    ~H"""
    <div data-slot="section" class={["flex flex-col gap-0.5", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global


  def sidebar_divider(assigns) do
    ~H"""
    <hr class={["my-4 border-t border-zinc-950/5 lg:-mx-4 dark:border-white/5", @class]} {@rest} />
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar_spacer(assigns) do
    ~H"""
    <div aria-hidden="true" class={["mt-8 flex-1", @class]} {@rest}></div>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar_heading(assigns) do
    ~H"""
    <h3 class={["mb-1 px-2 text-xs/6 font-medium text-zinc-500 dark:text-zinc-400", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </h3>
    """
  end

  attr :class, :string, default: nil
  attr :current, :boolean, default: false
  attr :href, :string
  slot :icon
  slot :avatar

  def sidebar_item(assigns) do

    ~H"""
    <span class="relative">
      <%= if @current do %>
        <span class="absolute inset-y-2 -left-4 w-0.5 rounded-full bg-zinc-950 dark:bg-white"></span>
      <% end %>
      <%= if @href do %>
        <.link navigate={@href} class={sidebar_item_classes(@class)} data-current={@current}>
          <%= render_slot(@icon) %>
          <%= render_slot(@avatar) %>
          <%= render_slot(@inner_block) %>
        </.link>
      <% else %>
        <button class={["cursor-default" | sidebar_item_classes(@class)]} data-current={@current} {@rest}>
          <%= render_slot(@icon) %>
          <%= render_slot(@avatar) %>
          <%= render_slot(@inner_block) %>
        </button>
      <% end %>
    </span>
    """
  end

  defp sidebar_item_classes(class) do
    [
      "flex w-full items-center gap-3 rounded-lg px-2 py-2.5 text-left text-base/6 font-medium text-zinc-950 sm:py-2 sm:text-sm/5",
      "data-[slot=icon]:*:size-6 data-[slot=icon]:*:shrink-0 data-[slot=icon]:*:fill-zinc-500 sm:data-[slot=icon]:*:size-5",
      "data-[slot=icon]:last:*:ml-auto data-[slot=icon]:last:*:size-5 sm:data-[slot=icon]:last:*:size-4",
      "data-[slot=avatar]:*:-m-0.5 data-[slot=avatar]:*:size-7 data-[slot=avatar]:*:[--ring-opacity:10%] sm:data-[slot=avatar]:*:size-6",
      "hover:bg-zinc-950/5 data-[slot=icon]:*:hover:fill-zinc-950",
      "data-[active]:bg-zinc-950/5 data-[slot=icon]:*:data-[active]:fill-zinc-950",
      "data-[slot=icon]:*:data-[current]:fill-zinc-950",
      "dark:text-white dark:data-[slot=icon]:*:fill-zinc-400",
      "dark:hover:bg-white/5 dark:data-[slot=icon]:*:hover:fill-white",
      "dark:data-[active]:bg-white/5 dark:data-[slot=icon]:*:data-[active]:fill-white",
      "dark:data-[slot=icon]:*:data-[current]:fill-white",
      class
    ]
  end

  attr :class, :string, default: nil
  attr :rest, :global

  def sidebar_label(assigns) do
    ~H"""
    <span class={["truncate", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end
end
