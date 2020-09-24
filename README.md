# JestService

TODO://

## Up and running
The JestService server can be started locally through mix, or through the docker image.
### Starting with mix
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Starting with docker image

## Usage
The JestService provides to endpoints, `/api/encode` and `/api/decode`.
To use the service, send a POST request to either endpoint with the appropriate parameters.

### Encode
Encoding a joke requires a POST to the `/api/encode` endpoint with a JSON object
containing a joke's body, punchline, and author. The response will contain the
encoded JESt message.

Example of JSON paramters: 
```JSON
{
  "body": "What do you call cheese that isn't yours",
  "punchline": "Nacho Cheese",
  "author": "Anita Bath"
}
```

An example curl request. The above JSON is available in the `encode_body.json` file.

```bash
curl -H "Content-Type: application/json" --data @encode_body.json http://localhost:4000/api/encode/
```

### Decode
Decoding a joke requires a POST to the `api/decode` endpoint with a JSON object
containing the JESt message. the response will contain the decoded JESt description.

Example of JSON paramters: 
```JSON
{"message": "What do you call cheese that isn't yours|4E6163686F20436865657365|Anita Bath"}
```

An example curl request. The above JSON is available in the `decode_body.json` file.

```bash
curl -H "Content-Type: application/json" --data @decode_body.json http://localhost:4000/api/encode/
```
