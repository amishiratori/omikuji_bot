module RandomIndex

  def self.get_random_index(weight_table)
    total_weight = weight_table.sum
    value = Random.rand(1..total_weight + 1)
    ret_index = -1

    for i in 0..(weight_table.length - 1) do
      if weight_table[i] >= value
        ret_index = i
        break
      end
      value -= weight_table[i]
    end
    return ret_index
  end

  def self.get_omikuji()
    weight_table = [10,32,17,13,28]
    index = RandomIndex.get_random_index(weight_table)
    if index == 0
      image = 'https://res.cloudinary.com/dg61muele/image/upload/v1570204284/daikichi_sfe8aa.jpg'
    elsif index == 1
      image = 'https://res.cloudinary.com/dg61muele/image/upload/v1570204284/kichi_lzmntc.jpg'
    elsif index == 2
      image = 'https://res.cloudinary.com/dg61muele/image/upload/v1570204284/chukichi_nsd1j3.jpg'
    elsif index == 3
      image = 'https://res.cloudinary.com/dg61muele/image/upload/v1570204284/suekichi_ea1z7m.jpg'
    else
      image = 'https://res.cloudinary.com/dg61muele/image/upload/v1570204284/kyou_zns58q.jpg'
    end
    return image
  end

end