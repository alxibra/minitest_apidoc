class Document
  attr_accessor :holders, :md
  def initialize holders
    self.holders = holders
  end
  def print
    # TODO italic markdown
    File.open("api_documentation.md", "wt") do |f|
      @md = Markdown.new
      holders.each do |holder|
       f.puts md.header(holder.klass_desc)
       holder.units.each do |unit|
         f.puts md.sub_header unit.name
         f.puts md.default(unit.test_desc)
         f.puts md.sub_sub_header unit.path_title
         f.puts md.italic unit.path
         f.puts md.sub_sub_header unit.method_title
         f.puts md.italic unit.method
         f.puts md.sub_sub_header unit.params_title
         f.puts md.code unit.params
         f.puts md.sub_sub_header unit.body_title
         f.puts md.code(unit.body)
         f.puts md.sub_sub_header unit.status_title
         f.puts md.italic unit.status
       end
      end
    end
  end
end
