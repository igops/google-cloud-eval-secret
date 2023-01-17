## A narrowly specialized docker image for evaluating the contents of Google Cloud Secrets

E.g., consider having a Google Cloud Secret with id `secret-id` in project `my-project` and value `echo 123`.
Then, running

```shell
$ docker run -it -e SECRET_PROJECT=my-project -e SECRET_ID=secret-id igops/google-cloud-eval-secret:latest
```
will do the following:
1. You will be asked to **authorize** using gcloud CLI
2. If you have **access** to the secret, its **latest version** will be loaded and **evaluated** so that `123` will be sent to STDOUT.

Sometimes, it might be a handy way of securely sharing some gcloud scripts.
E.g., you even can put a `gcloud compute ssh` command inside your secret, and it will work if a user has the corresponding permissions.

Restarting the same container will preserve your credentials:
```shell
$ docker run -it --name secret-eval -e SECRET_PROJECT=my-project -e SECRET_ID=secret-id igops/google-cloud-eval-secret:latest
... authorizaion
... evaluation
... exit
$ docker start -i secret-eval
... authorizaion is preserved, so it's skipped
... evaluation
... exit
```

## ENV variables
| Variable                    | Description                                   |
|-----------------------------|-----------------------------------------------|
| SECRET_PROJECT              | Google Cloud Project ID to load a secret from |
| SECRET_ID                   | Secret ID                                     |
| SECRET_VERSION              | Secret version, default is `latest`           |
