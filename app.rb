require 'sinatra'
require 'slim'

class Ticket
	attr_accessor :character
	attr_accessor :teacher
	attr_accessor :reason
	attr_accessor :purpose
	
	def initialize(character, reason, purpose)
		@character = character
		@reason = reason
		@purpose = purpose
		@replaced = false
	end

	def replaced?
		@replaced
	end
	def replaced=(value)
		@replaced = value
	end
end

configure do
	tickets = Array.new(6)
	# Hijack first record for column headers
	tickets[0] = Ticket.new('Name', 'How they won their ticket', 'What they want to do on the laptop')
	tickets[0].teacher = 'Class'
	tickets[0].replaced = true
	# Ticket owners before replacement
	tickets[1] = Ticket.new('Charlie Bucket', 'He was lucky really.', 'Manage his chocolate factory.')
	tickets[2] = Ticket.new('Veruca Salt', 'Daddy pulled strings for her.', 'Implement garbage collection.')
	tickets[3] = Ticket.new('Mike Teavee', 'He picked it up on Channel Two.', 'He will be upset YouTube is blocked.')
	tickets[4] = Ticket.new('Violet Beauregarde', 'She was lucky too.', 'She will research image colour correction.')
	tickets[5] = Ticket.new('Augustus Gloop', 'He played the numbers game.', 'He will do healthy eating research.')
	tickets[6] = Ticket.new('Tommy Troutbeck', 'Nobody knows.', 'He will plan a mountain climbing expedition.')
	set tickets: tickets
end

get '/' do
	slim :index 
end

post '/:n' do
	i = params['n'].to_i
	unless request['character'].empty?
		t = settings.tickets[i]
		t.character = request['character']
		t.teacher = request['teacher']
		t.reason = request['reason']
		t.purpose = request['purpose']
		t.replaced = true
	end
	redirect '/'
end
