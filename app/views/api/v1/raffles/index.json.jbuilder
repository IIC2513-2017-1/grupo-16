# frozen_string_literal: true

json.raffles do
  json.array! @raffles do |raffle|
    json.id raffle.id
    json.href api_v1_raffle_url(raffle)
    json.name raffle.name
    json.prize raffle.prize
    json.price raffle.price
    json.finish_date raffle.finish_date
    json.max_number raffle.max_number
    json.winner_id raffle.winner_id
  end
end