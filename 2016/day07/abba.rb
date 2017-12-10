class Abba
  attr_reader :ip_address

  # create 2 capture groups and match against each one
  ABBA_PATTERN = /(.)(.)\2\1/
  # http://stackoverflow.com/a/2403148/2100028
  HYPERNET_PATTERN = /\[([^\]]+)\]/

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def supports_tls?
    has_abba? && abba_valid?
  end

  private

  def abba_matches
    @abba_match ||= @ip_address.scan(ABBA_PATTERN)
  end

  def abba_in_string?(str)
    str.scan(ABBA_PATTERN).flatten.count > 0
  end

  def hypernet_sequences
    @hypernet_match ||= @ip_address.scan(HYPERNET_PATTERN).flatten
  end

  def has_abba?
    abba_in_string?(@ip_address) &&
    abba_matches.any? do |letters|
      letters[0] != letters[1]
    end
  end

  def hypernet_has_abba?
    hypernet_sequences.any? do |hypernet|
      abba_in_string?(hypernet)
    end
  end

  def abba_valid?
    hypernet_has_abba? == false
  end
end

class AbbaValidator
  def initialize(input, debug = false)
    @input = input
    @debug = debug
  end

  def count_tls
    @input.inject(0) do |count, ip_address|
      abba = Abba.new(ip_address)
      puts "#{ip_address} -> #{abba.supports_tls?}" if @debug
      count += 1 if abba.supports_tls?
      count
    end
  end
end

if __FILE__==$0
  test_input = [
    "abca[mnop]qrst",
    "abba[mnop]qrst",
    "abcd[bddb]xyyx",
    "aaaa[qwer]tyui",
    "ioxxoj[asdfgh]zxcvbn",
    "luqpeubugunvgzdqk[jfnihalscclrffkxqz]wvzpvmpfiehevybbgpg[esjuempbtmfmwwmqa]rhflhjrqjbbsadjnyc",
    "tjwhvzwmhppijorvm[egqxqiycnbtxrii]ojmqyikithgouyu[lrllrgezaulugvlj]jdsrysawxkpglgg[mpvkikuabwucwlpqf]cmzkcdnrhwjmfgbmlq"
  ]
  p AbbaValidator.new(test_input, true).count_tls
  p AbbaValidator.new(File.readlines("input.txt"), false).count_tls
end
