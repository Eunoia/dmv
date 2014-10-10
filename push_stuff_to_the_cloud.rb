module PushStuffToTheCloud
  def saveToS3(html,json)
    connection = Fog::Storage.new({
      :provider => "AWS",
      :endpoint => "http://s3.amazonaws.com",
      :region   => "us-west-1",
      :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
      :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
    })
    directory = connection.directories.get("www.soonestdmvappointment.com")
    file = directory.files.create(
      :key    => "index.html",
      :body   => html,
      :public => true
    )
    file = directory.files.create(
      :key    => "index.json",
      :body   => json,
      :public => true
    )
    file.public_url
  end
end
