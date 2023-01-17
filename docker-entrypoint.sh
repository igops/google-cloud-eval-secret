#!/bin/sh

if [ -z "$SECRET_PROJECT" ]
  then
    echo "SECRET_PROJECT is not set, please run with '-e SECRET_PROJECT=value'"
    exit 1
fi
if [ -z "$SECRET_ID" ]
  then
    echo "SECRET_ID is not set, please run with '-e SECRET_ID=value'"
    exit 1
fi

GOOGLE_ACCOUNT=$(gcloud config list account --format "value(core.account)" 2> /dev/null)
if [ -z "$GOOGLE_ACCOUNT" ]
  then
    gcloud auth login
  else
    echo "You are authorized as $GOOGLE_ACCOUNT. Please wait until the secret is evaluated..."
fi

eval $(gcloud secrets versions access $SECRET_VERSION --project=$SECRET_PROJECT --secret=$SECRET_ID)
