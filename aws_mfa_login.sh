#!/bin/bash

#make sure you have replace the mfa_device info here!
echo "only tested on MacOS!"
mfa_device="replace me with arn!!!"

if [[ $(which jq) ]]
then
  echo "jq is stalled!"
else
  brew install jq
fi

echo "unset environment variables"
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

if [[ $# -eq 0 ]]
then
  echo "Please pass in the maf token code, please input token code"
  read token_code
  credential=$(aws sts get-session-token --serial-number ${mfa_device} --token-code $token_code)
  echo $credential
else
  credential=$(aws sts get-session-token --serial-number ${mfa_device} --token-code $1)
  echo $credential
fi


AWS_ACCESS_KEY_ID=`echo $credential | jq '.Credentials' | jq -r '.AccessKeyId'`
AWS_SECRET_ACCESS_KEY=`echo $credential | jq '.Credentials' | jq -r '.SecretAccessKey'`
AWS_SESSION_TOKEN=`echo $credential | jq '.Credentials' | jq -r '.SessionToken'`

echo export "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
echo export "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
echo export "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"
export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN
#
# sed -i '' '/AWS_ACCESS_KEY_ID=.*/d' ~/.bash_profile
# sed -i '' '/AWS_SECRET_ACCESS_KEY=.*/d' ~/.bash_profile
# sed -i '' '/AWS_SESSION_TOKEN=.*/d' ~/.bash_profile
#
# echo "AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID >> ~/.bash_profile
# echo "AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY >> ~/.bash_profile
# echo "AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN >> ~/.bash_profile
