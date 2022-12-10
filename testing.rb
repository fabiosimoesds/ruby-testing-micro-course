require 'rspec'

class Hotel
  attr_accessor :guests, :rooms

  def initialize
    @guests = []
    @rooms = []
  end

  def check_in_guest(guest_name, room_number)
    return false if @rooms.include?(room_number)
    @guests << guest_name
    @rooms << room_number
    true
  end

  def check_out_guest(guest_name)
    room_index = @guests.index(guest_name)
    @rooms.delete_at(room_index)
    @guests.delete(guest_name)
  end
end

describe Hotel do
    let(:hotel) { Hotel.new }
    describe 'checking in a guest' do
        it "adds the guest to the hotel's guest list" do
            hotel.check_in_guest('George Harrison', 302)
            expect(hotel.guests).to include 'George Harrison'
        end
        context 'room is available' do
            it 'allows check-in' do
              expect(hotel.check_in_guest('George Harrison', 302)).to be true
            end
        end

        context 'room is not available' do
            it 'disallows check-in' do
                hotel.check_in_guest('Roy Orbison', 302)
                expect(hotel.check_in_guest('George Harrison', 302)).to be false
            end
            it "does not add the guest to the hotel's guest list" do
                hotel.check_in_guest('Roy Orbison', 302)
                hotel.check_in_guest('George Harrison', 302)
                expect(hotel.guests).not_to include 'George Harrison'
            end
        end
    end
    describe 'Check out' do         
        it 'can check a guest out' do
        hotel.check_in_guest('Fabio Santos', 330)
        hotel.check_out_guest('Fabio Santos')

        expect(hotel.guests).not_to include 'Fabio Santos'
        end

        it 'checking out as a guest should free the room' do
            hotel.check_in_guest('Fabio Santos', 330)
            hotel.check_out_guest('Fabio Santos')
            expect(hotel.rooms).not_to include 330
        end
    end
end