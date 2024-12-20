defmodule Catalyst.Storybook.Components.Alert do
  use PhoenixStorybook.Story, :component

  alias Catalyst.Alert

  def function, do: &Alert.alert/1

  def variation do
    [
      %Variation{
        id: "default",
        attributes: %{
          title: "Important update: Please read carefully"
        }
      }
    ]
  end
end
