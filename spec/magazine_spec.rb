require 'spec_helper'
require 'date'

describe References do
	describe References::Magazine do
		before :all do
		    @revista = References::Magazine.new(["Dave Thomas"],
			"Programming Ruby ",
			"The Facets of Ruby",
			"Pragmatic Bookshelf",4,Date.new(2013,7,7),
			"777744545-4-7874")
		end
		
		it "Debe poderse pasarle todos los argumentos necesarios" do
		    expect(References::Magazine.new(["Dave Thomas"],
			"Programming Ruby ",
			"The Facets of Ruby",
			"Pragmatic Bookshelf",4,Date.new(2013,7,7),
			"777744545-4-7874")).to_not be nil
		end
		
	    it "Debe ser un Magazine" do
		    expect(@revista.is_a?References::Magazine).to eq true 
		end
		
		it "Debe se una subclase de Reference" do
		    expect(@revista.is_a?References::Reference).to eq true 
		end
		
		it "Debe se una subclase de Object" do
		    expect(@revista.is_a?Object).to eq true 
		end
	    
	    it "Debe se una subclase de BasicObject" do
		    expect(@revista.is_a?BasicObject).to eq true 
		end
	end
end