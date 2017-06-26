# frozen_string_literal: true

json.raffle do
  json.id @raffle.id
  json.href api_v1_raffle_url(@raffle)
  json.name @raffle.name
  json.prize @raffle.prize
  json.price @raffle.price
  json.finish_date @raffle.finish_date
  json.max_number @raffle.max_number
  json.winner_id @raffle.winner_id
  json.user do
    json.id @raffle.user.id
    json.href api_v1_user_url(@raffle.user)
    json.email @raffle.user.email
    json.first_name @raffle.user.first_name
    json.last_name @raffle.user.last_name
  end
end
