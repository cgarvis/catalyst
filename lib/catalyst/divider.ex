defmodule Catalyst.Divider do
  use Phoenix.Component

  attr :class, :string, default: nil
  attr :soft, :boolean, default: false
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"

  def divider(assigns) do
    ~H"""
    <hr
      role="presentation"
      class={[
        "w-full border-t",
        @soft && "border-zinc-950/5 dark:border-white/5",
        !@soft && "border-zinc-950/10 dark:border-white/10",
        @class
      ]}
      {@rest}
    />
    """
  end
end
