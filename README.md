# Viafirma::Api

API for connect and manage e-sign with viafirma platform

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'viafirma-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install viafirma-api

## Usage

Viafirma API facade initialization:

    facade = ViafirmaApi::Facade.new(server: <address>, user: <username>, apikey: <apikey>)
    
By default the gem will use the port 80 for the requests, but you can change it with aditional parameter in the initialization hash (`port: <portnumber>`)

### Ping
For testing the connection with the API you can call the ping method of the facade

    facade.ping
the response should be a Hash like this:

    {:error=>false, :message=>nil, :response_code=>"SUCCESS", :result=>"pingResponse"}

### Prepare sign request
This method will throw the sign process throught the viafirma platform

    facade.prepare_sign_request(<personId>, <documentName>, <documentContent>, <returnURL>)

`personId`: Viafirma person id of active user that will sign.

`documentName`: Name of the document to sign.

`documentContent`: Binary content of the document to sign.

`returnURL`: Return url where the Viafirma will redirect after the sign request with the result of the sign.

The server response Hash for the call should include a redirectURL with the url where the user will sign the document.

### Other methods

For other methods of the API you can use it with the 'raw' savon call method and do dirty things :)
    
    facade.call(:get_request_info, message: { request_id: <requestId> })
The first parameter is the method name, and the last is a message payload hash with the request parameters. 

For further info check the [viafirma developers](https://developers.viafirma.com/en) page

## Contributing

1. Fork it ( https://github.com/[my-github-username]/viafirma-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
