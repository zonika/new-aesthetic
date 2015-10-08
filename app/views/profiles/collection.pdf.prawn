require 'open-uri'

prawn_document(:page_layout => :portrait) do |pdf|

  pdf.font('Helvetica')
  pdf.font_size(26)
  pdf.move_down(72*3)
  pdf.text(current_user.full_name + "'s Collection", :align => :center)
  pdf.font_size(12)

  pdf.start_new_page

  current_user.pieces.each_with_index do |piece,i|

    pdf.bounding_box([65, pdf.cursor], :width => 400, :height => 500) do
      pdf.image(open(piece.image.url(:large)), :fit => [400, 500], :vposition => :bottom, :position => :center)
    end

    pdf.move_down(20)
    pdf.bounding_box([65, pdf.cursor], :width => 200, :height => 100) do
      pdf.font('Helvetica',:style => :italic)
      pdf.text(piece.name, :styles => [:italics])
      pdf.font('Helvetica',:style => :normal)
      pdf.text(current_user.full_name)                                                      
    end

    pdf.move_down(120)
    pdf.font_size(8)
    pdf.text("- #{i+1} -", :align => :center)
    pdf.font_size(12)

    pdf.start_new_page 

  end

  


  pdf.move_down(72*10)
  pdf.text("New-Aesthetic", :align => :center)
end
