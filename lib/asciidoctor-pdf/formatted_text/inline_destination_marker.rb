module Asciidoctor::Pdf::FormattedText
module InlineDestinationMarker
  module_function

  # render_behind is called before the text is printed
  def render_behind fragment
    unless (pdf = fragment.document).scratch?
      if (name = fragment.format_state[:name])
        if fragment.format_state[:type] == :indexterm
          (pdf.instance_variable_get :@index).link_dest_to_page name, pdf.page_number
        end
        # get precise position of the reference (x, y)
        dest_rect = fragment.absolute_bounding_box
        pdf.add_dest name, (pdf.dest_xyz dest_rect.first, dest_rect.last)
        # prevent any text from being written
        fragment.conceal
      end
    end
  end
end
end
