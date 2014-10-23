class Wrapper
  def self.wrap sentence, column
    return sentence if sentence.length < column
    
    line_break = sentence[0...column].rindex(" ") || column
    sentence[0...line_break] + "\n" + wrap(sentence[line_break..-1].strip,column)
  end
end

describe Wrapper, "wrap" do
  it "empty should return emtpy" do
    expect(Wrapper.wrap "", 5).to eq ""
  end
  it "word shorter than column should return word as is" do
    expect(Wrapper.wrap "agiles", 10).to eq "agiles"
  end
  it "word larger than column should break at column" do
    expect(Wrapper.wrap "agiles2014", 6).to eq "agiles\n2014"
  end
  it "word twice larger than column should break twice at column" do
    expect(Wrapper.wrap "agiles2014", 4).to eq "agil\nes20\n14"
  end

  context "with 1 space" do
    it "before column should break at space" do
      expect(Wrapper.wrap "agiles 2014", 9).to eq "agiles\n2014"
    end
    it "after column should break at column" do
      expect(Wrapper.wrap "agiles 2014", 5).to eq "agile\ns\n2014"
    end
  end

  context "with 2 spaces" do
    it "column after last space should break at last space" do
      expect(Wrapper.wrap "super agiles 2014", 15).to eq "super agiles\n2014"
    end
    it "column after first space should break at first space" do
      expect(Wrapper.wrap "super agiles 2014", 9).to eq "super\nagiles\n2014"
    end
  end

  context "with many spaces" do
    it "should break at column or right before space" do
      expect(Wrapper.wrap "agiles 2014 is the most amazing event i have ever attended", 15).to eq "agiles 2014 is\nthe most\namazing event\ni have ever\nattended"
    end
  end
end