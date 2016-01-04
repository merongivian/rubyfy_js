require 'wrappable'
require 'opal/fixtures/methods'

require 'opal/fixtures/accessors/simple_types'
require 'opal/fixtures/accessors/object_types'

describe Wrappable do
  let(:native_methods) { Object.methods + %w[to_n wrappable_accessor] }

  describe 'instance methods' do
    before {
      class Person
        include Wrappable
      end
    }

    let!(:juan) { Person.new }

    it 'replicates an existing js method' do
      expect(juan.greet 'Ana')
        .to eq 'Hey Ana, nice to meet you'
    end

    it 'aliases (only public) methods in snake case' do
      expect(juan.methods - native_methods)
        .to match_array [
          :say_hello,
          :say_bye,
          :greet
        ]
    end
  end

  describe 'accessors for simple types' do
    before {
      class Car
        include Wrappable
      end
    }

    let!(:car) { Car.new(1998, 13) }

    it 'creaters a getter and a setter for year' do
      expect(car.year).to eq 1998
      car.year = 2015
      expect(car.year).to eq 2015
    end

    it 'creates a getter and a setter for price' do
      expect(car.price).to eq 13
      car.price = 14
      expect(car.price).to eq 14
    end
  end

  describe 'accesors for object types' do
    before {
      class Lion
        include Native
      end

      class Puma
        include Native
      end

      class Zebra
        include Native
      end

      class Jungle
        include Wrappable

        attr_wrap :littlePuma, Puma
        attr_wrap :bigLion, Lion
        attr_wrap :littleZebra, Zebra
      end
    }

    xit 'wraps object attributes' do
      expect(Jungle.new.bigLion).to be_a Lion
      #expect(Jungle.new.little_puma).to be_a Puma
      #expect(Jungle.new.little_zebra).to be_a Zebra
    end
  end
end
