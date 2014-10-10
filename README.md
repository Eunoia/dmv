dmv
===

Don't wait in line! Get the next appointment for the California DMV.

Did you know that you can skip the line at the DMV? 

By making an appointment online, you can save time by getting ahead of the people who walked in. 

What if your favorite DMV has no available appointments? 

You can use this list to find the next available appointment for all the DMV offices in the state of California.

## Technology

This app has two parts, the report generation on Heorku, and the report hosted on Amazon S3. 

To get the app running locally you will need to:

1. The name of your S3 bucket for appointment times, and your AWS keys. 
2. Modify `PushStuffToTheCloud.saveToS3` to use your bucket, not mine. 
3. Generate the report by running `AWS_ACCESS_KEY_ID=AKIAFOO AWS_SECRET_ACCESS_KEY="yourKeyHere" bundle exec rake update_listing`

There is a small sinatra app with sample data for modifying how reports should look. To get it running:

1. `bundle install`
2. `ruby app.rb`
3. Navigate your browser to localhost:4567

To deploy on Heroku, you will need to set up a scheduler to run the rake task. To avoid unnecessary billing, shut off the web process with `heroku ps:scale web=0`


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
