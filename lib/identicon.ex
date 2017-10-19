defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello
      :world

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
  end

  def hash_input(input) do
    # passes input value to hashing method which returns a list of hex numbers
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    # pass list of numbers to Identicon.Image to create struct and set list of numbers to hex prop on struct
    # return struct, which is passed to pick_color
    %Identicon.Image{hex: hex}
  end

  def pick_color(image) do
    # pattern matching of structs
    # %Identicon.Image{hex: hex_list} = %Identicon.Image{hex: [13, 245, 187...]}
    # assigns the value of hex (the list) to hex_list
    %Identicon.Image{hex: hex_list} = image
    # assigns first three vlaues in hex_list to r, g, and b
    [r, g, b | _tail] = hex_list

    # return new struct with added color prop that is a tuple with color values
    %Identicon.Image{image | color: {r, g, b}}
  end
  
  # equivalent JS code to pick_color
    # pick_color: function(image) {
    #   image.color = {
    #     r: image.hex[0],
    #     g: image.hex[1],
    #     b: image.hex[2]
    #   }

    #   return image;
    # }


  # pattern matching in parameter
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end
      %Identicon.Image{image| grid: grid}
  end

  def build_pixel_map() do
    
  end

  def draw_image() do
    
  end
end
