defmodule(Kayrock.DeleteGroups) do
  @moduledoc false
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  defmodule(V0.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(groups: [], correlation_id: nil, client_id: nil)
    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:delete_groups)
    end

    def(api_vsn) do
      0
    end

    def(response_deserializer) do
      &V0.Response.deserialize/1
    end

    def(schema) do
      [groups: {:array, :string}]
    end

    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [serialize_array(:string, Map.fetch!(struct, :groups))]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V0.Request) do
    def(serialize(%V0.Request{} = struct)) do
      try do
        V0.Request.serialize(struct)
      rescue
        e ->
          reraise(Kayrock.InvalidRequestError, {e, struct}, System.stacktrace())
      end
    end

    def(api_vsn(%V0.Request{})) do
      V0.Request.api_vsn()
    end

    def(response_deserializer(%V0.Request{})) do
      V0.Request.response_deserializer()
    end
  end

  def(get_request_struct(0)) do
    %V0.Request{}
  end

  defmodule(V0.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(throttle_time_ms: nil, group_error_codes: [], correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:delete_groups)
    end

    def(api_vsn) do
      0
    end

    def(schema) do
      [
        throttle_time_ms: :int32,
        group_error_codes: {:array, [group_id: :string, error_code: :int16]}
      ]
    end

    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data

      deserialize_field(
        :root,
        :throttle_time_ms,
        %__MODULE__{correlation_id: correlation_id},
        rest
      )
    end

    defp(deserialize_field(:root, :throttle_time_ms, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:root, :group_error_codes, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:group_error_codes, :group_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:group_error_codes, :error_code, Map.put(acc, :group_id, val), rest)
    end

    defp(deserialize_field(:group_error_codes, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:group_error_codes, nil, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :group_error_codes, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:group_error_codes, :group_id, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :group_error_codes, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  def(deserialize(0, data)) do
    V0.Response.deserialize(data)
  end

  def(min_vsn) do
    0
  end

  def(max_vsn) do
    0
  end
end
