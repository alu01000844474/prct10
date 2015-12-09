# coding: utf-8
require 'spec_helper'
require 'date'

describe References do
	describe References::Node do
		before :each do
			@node2 = References::Node.new("dato2",nil)
			@node = References::Node.new("dato", @node2) 
		end

		it 'Debe existir un nodo de la lista con sus datos y su siguiente'  do
			expect(@node.value).to eq "dato"
			expect(@node.next).to be @node2
		end
	end
	describe References::List do
		before :all do
			@list = References::List.new(0)
			@list2 = References::List.new()
			@list3 = References::List.new(0,1,2,3,4,5,6,7,8,9)
			@list4 = References::List.new("head","last")
      @list5 = References::List.new('a','b','c')
		end

		it 'Se extrae el primer elemento de la lista' do
			expect(@list.takeFirst).to eq 0
			expect(@list.takeFirst).to eq nil
		end

    it 'Se extrae el ultimo elemento de la lista' do
      expect(@list5.takeLast).to eq 'c'
      expect(@list5.last).to eq 'b'
      expect(@list5.takeLast).to eq 'b'
      expect(@list5.last).to eq 'a'
      expect(@list5.takeLast).to eq 'a'
    end

		it 'Se puede insertar al principio un elemento' do
			expect(@list2.takeFirst).to eq nil
			expect(@list2.put("hola")).to eq nil
			expect(@list2.takeFirst).to eq "hola"
		end

    it 'Se puede insertar un elemento al final' do
      @list.pushEnd(5)
      expect(@list.last).to eq 5
    end

		it 'Se puede insertar varios elementos' do 
			expect(@list3.length).to eq 10
			@list3.takeFirst
			expect(@list3.length).to eq 9
		end

		it 'Debe existir una lista con su cabeza' do 
			expect(@list4.head).to eq "head"
		end

    it 'Debe existir una lista con su ultimo elemeto ' do
      expect(@list4.last).to eq "last"
    end
	end
  describe "La lista cumple los requisito de enumerable" do
    before :each do
      @ruby = References::Book.new([References::Name.new("Thomas","Dave"),
                                         References::Name.new("Hunt","Andy"),
                                         References::Name.new(" Fowler","Chad")],
                                        "Programmin Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide",
                                        "The Facets of Ruby",
                                        "Pragmatic Bookshelf",
                                        4,
                                        Date.new(2013,7,7),
                                        ["ISBN-13: 978-1937785499","ISBN-10: 1937785491"])

      @git = References::Book.new([References::Name.new("Chacon","Scott")],
                                       "Pro Git 2009th Edition",
                                       "Pro",
                                       "Apress",
                                       2009,
                                       Date.new(2009,8,27),
                                       ["ISBN-13: 9781430218333", "ISBN-12: 1430218339"])

      @ruby2 = References::Book.new([References::Name.new("Flanagan","David"),
                                          References::Name.new("Matsumoto","Yukihiro")],
                                         "The Ruby Programmin Language",
                                         nil,
                                         "O'Really Media",
                                         1,
                                         Date.new(2008,2,4),
                                         ["ISBN-10: 0596516177", "ISBN-13: 978-0596516178"])

      @rspec = References::Book.new([References::Name.new("Chelimsky","David"), References::Name.new("Astels","Dave")],
                                         "The RSpec Book: Behaviour Driven Development with RSpec, Cucumber, and Friends",
                                         "The Facets of Ruby",
                                         "Pragmatic Bookshelf",
                                         1,
                                         Date.new(2012,12,25),
                                         ["ISBN-10: 1934356379","ISBN-13: 978-1934356371"])

      @git2 =References::Book.new([References::Name.new("Silverman","Richard")],
                                       "Git Pocket Guide",
                                       nil,
                                       "O'Really Media",
                                       1,
                                       Date.new(2013, 8, 2),
                                       ["ISBN-10: 1449325866","ISBN-13: 978-1449325862"])

      @list = References::List.new(@ruby, @git, @ruby2, @rspec, @git2)
      @list_empty = References::List.new()
    end

    it "Pruebas con lista de referencias" do
      expect(@list.takeLast).to be @git2
      expect(@list.takeLast).to be @rspec
      expect(@list.takeLast).to be @ruby2
      expect(@list.takeLast).to be @git
      expect(@list.takeLast).to be @ruby
    end

    it "Enumerable implementado?" do
      expect(@list.inject(true) do |state, libro|
               state && libro.instance_of?(References::Book)
             end).to be true
    end

    it "comprobrando el metodo all?" do
      expect(@list.all?).to eq(true)
    end

    it "comprobrando el metodo any?" do
      expect(@list_empty.any?).to eq(false)
    end

    it "comprobrando el metodo collect" do
      expect(@list.map{|i| i}).to eq([@ruby,@git,@ruby2,@rspec,@git2])
      expect(@list.collect{|i| i}).to eq([@ruby,@git,@ruby2,@rspec,@git2])
    end

    it "comprobrando el metodo count" do
      expect(@list.count).to eq(5)
    end

    it "comprobrando el metodo detect" do
      expect(@list.detect {|i| i == @git}).to eq(@git)
      expect(@list.find {|i| false }).to eq(nil)
    end

    it "comprobrando drop" do
      expect(@list.drop(4)).to eq([@git2])
    end

    it "comprobrando max" do
      expect(@list.max).to eq(@ruby2)
    end

    it "comprobrando min" do
      expect(@list.min).to eq(@git2)
    end

    it "comprobrando sort" do
      expect(@list.sort).to eq([@git2,@ruby,@rspec,@git,@ruby2])
    end

    it "formato APA" do
      expect(@list.to_s).to eq "Silverman, R. (2013) Git Pocket Guide
\t(O'Really Media) (1) ISBN-10: 1449325866, ISBN-13: 978-1449325862
Thomas, D. Hunt, A.  & Fowler, C. (2013) Programmin Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide: The Facets of Ruby.
\t(Pragmatic Bookshelf) (4) ISBN-13: 978-1937785499, ISBN-10: 1937785491
Chelimsky, D.  & Astels, D. (2012) The RSpec Book: Behaviour Driven Development with RSpec, Cucumber, and Friends: The Facets of Ruby.
\t(Pragmatic Bookshelf) (1) ISBN-10: 1934356379, ISBN-13: 978-1934356371
Chacon, S. (2009) Pro Git 2009th Edition: Pro.
\t(Apress) (2009) ISBN-13: 9781430218333, ISBN-12: 1430218339
Flanagan, D.  & Matsumoto, Y. (2008) The Ruby Programmin Language
\t(O'Really Media) (1) ISBN-10: 0596516177, ISBN-13: 978-0596516178"
    end

  end
end
