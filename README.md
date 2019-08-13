# web-pc-oracle
Spring boot flight microservice for exposing REST API

# kubernetes configuration

```
kubectl create secret generic db-creds \
        --from-literal=db.user=admin \
        --from-literal=db.password=<DB_PASSWORD> -n namespace
```
