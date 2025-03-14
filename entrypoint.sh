#!/bin/bash

set -e

git config --global user.name "Docker Build" &&
git config --global user.email "docker@example.com"

if git ls-remote --heads "https://$INPUT_USER:$INPUT_TOKEN@$INPUT_GITHUB_DOMAIN/$INPUT_REPO.git" $INPUT_BRANCH | grep -q $INPUT_BRANCH; then
  echo "Branch $INPUT_BRANCH exists, deploying..."

  git clone "https://$INPUT_USER:$INPUT_TOKEN@$INPUT_GITHUB_DOMAIN/$INPUT_REPO.git" --branch $INPUT_BRANCH --single-branch tmp
  rm -rf tmp/*
  cp -r $INPUT_FOLDER/* tmp/
  cd tmp
  git add .
  git commit -m "Deploy to Pages from Dockerfile"
  git push --force "https://$INPUT_USER:$INPUT_TOKEN@$INPUT_GITHUB_DOMAIN/$INPUT_REPO.git" $INPUT_BRANCH

else
  echo "Branch $INPUT_BRANCH does not exist, creating..."

  git clone "https://$INPUT_USER:$INPUT_TOKEN@$INPUT_GITHUB_DOMAIN/$INPUT_REPO.git" tmp_base
  cd tmp_base $INPUT_BRANCH
  git switch --orphan 
  cp -r ../$INPUT_FOLDER/* .
  git add .
  git commit -m "Initial commit to $INPUT_BRANCH"
  git push --set-upstream "https://$INPUT_USER:$INPUT_TOKEN@$INPUT_GITHUB_DOMAIN/$INPUT_REPO.git" $INPUT_BRANCH
fi

echo "Deployment completed."
