# 
2 api endpoints :

/encrypt takes a json payload, see example `encrypt_payload` in api/

```bash
curl --header "Content-Type: application/json" -X POST -d '{"String": "dummy"}' https://api.mark-ferrari.com/encrypt/encrypt
```

/decrypt is similar but pass in the known shasum and it will return a match.

```bash
curl --header "Content-Type: application/json" -X POST -d '{"Shasum": "b5a2c96250612366ea272ffac6d9744aaf4b45aacd96aa7cfcb931ee3b558259"}' https://api.mark-ferrari.com/decrypt
```

## Known issues
When posting to `/encrypt/encrypt` - it returns a generic 500 error, but the records are being updated in DynamoDB so not entirely sure what the problem there is.

## Thoughts
Initially wanted to use an ALB in front of some lambda target groups but was having issues passing the payload onto lambda. 
API Gateway in terraform is incredibly messy, I got the initial setup done but had to finish it through the console. Silly things like not having a clean way to link DNS records to the API gateway.
