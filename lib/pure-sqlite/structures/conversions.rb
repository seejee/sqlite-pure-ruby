module Conversions
  SIGNED_64_BIT_MAX   = 2**63
  UNSIGNED_64_BIT_MAX = 2**64

  def self.twos_complement(value)
    if value > SIGNED_64_BIT_MAX
      value - UNSIGNED_64_BIT_MAX
    else
      value
    end
  end
end
