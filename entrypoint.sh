#!/bin/bash

set -e

if [ -z "$INPUT_ARGS" ]; then
  echo 'Required Args parameter'
  exit 1
fi


git config --global user.name "Docker Build" &&
git config --global user.email "docker@example.com"

if git ls-remote --heads "https://$USER:$TOKEN@$GITHUB_DOMAIN/$REPO.git" $BRANCH | grep -q $BRANCH; then
  echo "Branch $BRANCH exists, deploying..."

  git clone "https://$USER:$TOKEN@$GITHUB_DOMAIN/$REPO.git" --branch $BRANCH --single-branch tmp
  rm -rf tmp/*
  cp -r $FOLDER/* tmp/
  cd tmp
  git add .
  git commit -m "Deploy to Pages from Dockerfile"
  git push --force "https://$USER:$TOKEN@$GITHUB_DOMAIN/$REPO.git" $BRANCH

else
  echo "Branch $BRANCH does not exist, creating..."

  git clone "https://$USER:$TOKEN@$GITHUB_DOMAIN/$REPO.git" tmp_base
  cd tmp_base $BRANCH
  git switch --orphan 
  cp -r ../$FOLDER/* .
  git add .
  git commit -m "Initial commit to $BRANCH"
  git push --set-upstream "https://$USER:$TOKEN@$GITHUB_DOMAIN/$REPO.git" $BRANCH
fi

echo "Deployment completed."
