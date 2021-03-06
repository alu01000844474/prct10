# coding: utf-8
require "references"

module References
    class Magazine < Reference
        def initialize(autores, titulo, serie, edicion, numeroedicion, fecha, issbn)
            super(autores, titulo, serie, edicion, numeroedicion, fecha, ["issbn:"+issbn])
            @issbn = issbn
            @title = @title.split(" ").map { |x| if x.length >= 4 then x[0].upcase + x[1..-1] end }.join(" ")
        end
        # Format book reference to APA standard
        # @return [String] format output
        def formatAPA
          (prettyOutput(@authors.map { |x| x.to_s }) + "(" + @date.year.to_s + ") " + @title +
           "\n\t(" + @edition.to_s + ") " +
           "(" + @editionnumber.to_s + ") " +
           @issbn)
        end
    end
end
