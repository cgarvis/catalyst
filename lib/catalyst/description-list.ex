defmodule Catalyst.DescriptionList do
  use Phoenix.Component

  attr(:class, :string, default: nil)
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the flash container")

  slot(:inner_block)

  def dl(assigns) do
    ~H"""
    <dl class={["grid grid-cols-1 text-base/6 sm:grid-cols-[min(50%,theme(spacing.80))_auto] sm:text-sm/6", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </dl>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the flash container")

  slot(:inner_block)

  def dt(assigns) do
    ~H"""
    <dt class={["col-start-1 border-t border-zinc-950/5 pt-3 text-zinc-500 first:border-none sm:border-t sm:border-zinc-950/5 sm:py-3 dark:border-white/5 dark:text-zinc-400 sm:dark:border-white/5", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </dt>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the flash container")

  slot(:inner_block)

  def dd(assigns) do
    ~H"""
    <dd class={["pb-3 pt-1 text-zinc-950 sm:border-t sm:border-zinc-950/5 sm:py-3 dark:text-white dark:sm:border-white/5 sm:[&:nth-child(2)]:border-none", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </dd>
    """
  end
end
