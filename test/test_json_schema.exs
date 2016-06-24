defmodule JSTest do
  use ExUnit.Case

  @js %{
	    "type"=> "object",
	    "properties"=> %{
	      "comment_id"=> %{
		      "type"=> "string",
              "minLength"=> 27,
              "maxLength"=> 27
	      }
	    },
	    "required"=> ["comment_id"]
	  }
  @schema ExJsonSchema.Schema.resolve(@js)
  @f %{"comment_id" => "12345678901234567890123"}

  test "js test" do
     IO.inspect ExJsonSchema.Validator.validate(@schema, @f)
  end

  test "base" do
      schema = %{
        "type" => "object",
        "properties" => %{
          "foo" => %{
            "type" => "string"
          }
        }
      } |> ExJsonSchema.Schema.resolve
      IO.inspect ExJsonSchema.Validator.validate(schema, %{"foo" => "bar"})
      IO.inspect ExJsonSchema.Validator.validate(schema, %{"foo" => 1})
  end

  test "target" do
    s = %{
	  "definitions"=> %{
		"objectid"=> %{
		    "type"=> "string",
		    "minLength"=> 25,
		    "maxLength"=> 25
		}},
	    "type"=> "object",
	    "properties"=> %{
	      "comment_id"=> %{
		      "$lref"=> "#/definitions/objectid"
	      }
	    },
	    "required"=> ["comment_id"]
	  }
    schema = ExJsonSchema.Schema.resolve(s)
    f = %{"comment_id" => "12345678901234567890123"}
    IO.inspect ExJsonSchema.Validator.validate(schema, f)
  end
end

