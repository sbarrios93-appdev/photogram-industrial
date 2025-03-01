task sample_data: :environment do
  starting = Time.now
  user_count = 12

  if Rails.env.development?
    p "Deleting previous sample data"
    FollowRequest.delete_all
    Comment.delete_all
    Like.delete_all
    Photo.delete_all
    User.delete_all
  end

  p "Creating sample data"
  # Create users
  p "Creating users"
  user_count.times do
    User.create!(
      email: Faker::Internet.email,
      password: Faker::Internet.password(min_length: 8),
      private: Faker::Boolean.boolean,
      username: Faker::Internet.username,
    )
  end
  p "#{User.count} users have been created"

  users = User.all
  p "Creating follow requests"
  users.each do |first_user|
    users.each do |second_user|
      if first_user != second_user
        if Faker::Boolean.boolean(true_ratio: 0.8)
          first_user.sent_follow_requests.create(
            recipient: second_user,
            status: FollowRequest.statuses.values.sample,
          )
        end

        if Faker::Boolean.boolean(true_ratio: 0.8)
          second_user.sent_follow_requests.create(
            recipient: first_user,
            status: FollowRequest.statuses.values.sample,
          )
        end
      end
    end
  end
  p "#{FollowRequest.count} follow requests have been created"

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}",
      )

      user.followers.each do |follower|
        if Faker::Boolean.boolean(true_ratio: 0.5)
          photo.fans << follower
        end

        if Faker::Boolean.boolean(true_ratio: 0.2)
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower,
          )
        end
      end
    end
  end
  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{FollowRequest.count} follow requests."
  p "There are now #{Photo.count} photos."
  p "There are now #{Like.count} likes."
  p "There are now #{Comment.count} comments."
end
