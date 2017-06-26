# frozen_string_literal: true

json.user do
  json.id @current_user.id
  json.href api_v1_user_url(@current_user)
  json.email @current_user.email
  json.first_name @current_user.first_name
  json.last_name @current_user.last_name
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
end