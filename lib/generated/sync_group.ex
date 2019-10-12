defmodule(Kayrock.SyncGroup) do
  @moduledoc false
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  defmodule(V0.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      group_id: nil,
      generation_id: nil,
      member_id: nil,
      group_assignment: [],
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sync_group)
    end

    def(api_vsn) do
      0
    end

    def(response_deserializer) do
      &V0.Response.deserialize/1
    end

    def(schema) do
      [
        group_id: :string,
        generation_id: :int32,
        member_id: :string,
        group_assignment: {:array, [member_id: :string, member_assignment: :bytes]}
      ]
    end

    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [
          serialize(:string, Map.fetch!(struct, :group_id)),
          serialize(:int32, Map.fetch!(struct, :generation_id)),
          serialize(:string, Map.fetch!(struct, :member_id)),
          case(Map.fetch!(struct, :group_assignment)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:string, Map.fetch!(v, :member_id)),
                    case(Map.fetch!(v, :member_assignment)) do
                      %Kayrock.MemberAssignment{} = m ->
                        Kayrock.Serialize.serialize(
                          :iodata_bytes,
                          Kayrock.MemberAssignment.serialize(m)
                        )

                      b when is_binary(b) ->
                        Kayrock.Serialize.serialize(:bytes, b)
                    end
                  ]
                end
              ]
          end
        ]
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

  defmodule(V1.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      group_id: nil,
      generation_id: nil,
      member_id: nil,
      group_assignment: [],
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sync_group)
    end

    def(api_vsn) do
      1
    end

    def(response_deserializer) do
      &V1.Response.deserialize/1
    end

    def(schema) do
      [
        group_id: :string,
        generation_id: :int32,
        member_id: :string,
        group_assignment: {:array, [member_id: :string, member_assignment: :bytes]}
      ]
    end

    def(serialize(%V1.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [
          serialize(:string, Map.fetch!(struct, :group_id)),
          serialize(:int32, Map.fetch!(struct, :generation_id)),
          serialize(:string, Map.fetch!(struct, :member_id)),
          case(Map.fetch!(struct, :group_assignment)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:string, Map.fetch!(v, :member_id)),
                    case(Map.fetch!(v, :member_assignment)) do
                      %Kayrock.MemberAssignment{} = m ->
                        Kayrock.Serialize.serialize(
                          :iodata_bytes,
                          Kayrock.MemberAssignment.serialize(m)
                        )

                      b when is_binary(b) ->
                        Kayrock.Serialize.serialize(:bytes, b)
                    end
                  ]
                end
              ]
          end
        ]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V1.Request) do
    def(serialize(%V1.Request{} = struct)) do
      try do
        V1.Request.serialize(struct)
      rescue
        e ->
          reraise(Kayrock.InvalidRequestError, {e, struct}, System.stacktrace())
      end
    end

    def(api_vsn(%V1.Request{})) do
      V1.Request.api_vsn()
    end

    def(response_deserializer(%V1.Request{})) do
      V1.Request.response_deserializer()
    end
  end

  def(get_request_struct(0)) do
    %V0.Request{}
  end

  def(get_request_struct(1)) do
    %V1.Request{}
  end

  defmodule(V0.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(error_code: nil, member_assignment: nil, correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sync_group)
    end

    def(api_vsn) do
      0
    end

    def(schema) do
      [error_code: :int16, member_assignment: :bytes]
    end

    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data
      deserialize_field(:root, :error_code, %__MODULE__{correlation_id: correlation_id}, rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :member_assignment, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :member_assignment, acc, data)) do
      {val, rest} = Kayrock.MemberAssignment.deserialize(data)
      deserialize_field(:root, nil, Map.put(acc, :member_assignment, val), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  defmodule(V1.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(throttle_time_ms: nil, error_code: nil, member_assignment: nil, correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sync_group)
    end

    def(api_vsn) do
      1
    end

    def(schema) do
      [throttle_time_ms: :int32, error_code: :int16, member_assignment: :bytes]
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
      deserialize_field(:root, :error_code, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :member_assignment, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :member_assignment, acc, data)) do
      {val, rest} = Kayrock.MemberAssignment.deserialize(data)
      deserialize_field(:root, nil, Map.put(acc, :member_assignment, val), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  def(deserialize(0, data)) do
    V0.Response.deserialize(data)
  end

  def(deserialize(1, data)) do
    V1.Response.deserialize(data)
  end

  def(min_vsn) do
    0
  end

  def(max_vsn) do
    1
  end
end
