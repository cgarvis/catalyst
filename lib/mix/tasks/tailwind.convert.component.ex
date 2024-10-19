defmodule Mix.Tasks.Tailwind.Convert.Component do
  @moduledoc "Convert a TailWind component to Elixir/Phoenix component"
  @shortdoc "Convert to phx component"
  @requirements ["app.start"]

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    case args do
      [filename] ->
        convert_component(filename)

      _ ->
        IO.puts """
        Usage: mix tailwind.convert.component <filename>
        """
    end
  end

  defp convert_component(filename) do
    client = Ollama.init()

    {:ok, content} = File.read(filename)
    {:ok, resp} = Ollama.completion(client, [
      #model: "deepseek-coder:6.7b",
      model: "llama3.2",
      system: ~s"""
      You are a React TypeScript and Elixir Phoenix expert.
      You will be given a react component in typescript and you need to convert it to an Elixir Phoenix component.
      It should be namespaced to `Catalyst`.
      It should create a file in the `lib/catalyst` folder
      It should use `attr` and `slot` macros.
      It should have all the react components converted to Elixir.
      For `TouchTarget` use `<.link>`.
      For `Headless.Button` use `<.button>`.
      Ignore `LayoutGroup` and `motion`.
      `ref` can be ignored.
      For `children` use `@inner_block`.
      for `cslx` use a List like `["flex", @class]`.

      Each component should be nested in the parent compenent.

      Any example of what a component in Phoenix should look:

      ```elixir
      defmodule Catalyst.Navbar do
        use Phoenix.Component  

        attr :class, :string, default: nil
        attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"
        slot :inner_block

        def navbar(assigns) do
          ~H\"\"\"
          <nav class={["flex flex-1 items-center gap-4 py-2.5", @class]} {@rest}>
            <%= render_slot(@inner_block) %>
          </nav>
          \"\"\"
        end
      
        def navbar_divider(assigns) do
          ~H\"\"\"
          <div class={["border-r border-gray-200", @class]} {@rest}></div>
          \"\"\"
        end
      end
      ```

      Return just the elixir code.
      """,
      prompt: ~s"""
      The react component to convert:

      ```tsx
      #{content}
      ```
      """,
    ])

    #dbg(resp["response"])

    elixir_code = parse_elixir_code_block(resp["response"])
    output_filename = Path.basename(filename, ".tsx") <> ".ex"
    output_path = Path.join(["lib", "catalyst", output_filename])
    #dbg(elixir_code)
    File.write!(output_path, elixir_code)

    IO.puts("Converted component written to: #{output_path}")
  end

  defp parse_elixir_code_block(response) do
    ~r/```elixir\n([\s\S]*?)```/
    |> Regex.run(response, capture: :all_but_first)
    |> List.first()
    |> String.trim()
  end
end
