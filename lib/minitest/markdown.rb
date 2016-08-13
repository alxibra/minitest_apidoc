class Markdown
  def header text
    '# ' + text
  end

  def sub_header text
    '## ' + text
  end

  def sub_sub_header text
    '### ' + text
  end
  
  def default text
    text
  end

  def next_line
    ''
  end

  def code text
    text = text.is_a?(Hash) ? text : eval(text.gsub('null', 'nil'))
    "```json \n " +
    JSON.pretty_generate(text) + "\n" +
    "```"
  end

  def italic text
    "*#{text}*"
  end
end
