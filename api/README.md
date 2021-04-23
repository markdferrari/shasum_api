# 
2 api endpoints :

/encrypt takes a json payload, see example `encrypt_payload` in api/

```bash
curl --header "Content-Type: application/json" -x POST -d '{"String": "$insertanyvalue"} http://api.mark-ferrari.com/encrypt
```

/decrypt is similar but pass in the known shasum and it will return a match.

```bash
curl --header "Content-Type: application/json" -x POST -d '{"Shasum": "$known_shasum"} http://api.mark-ferrari.com/decrypt
```