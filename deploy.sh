#!/bin/sh

APP_NAME=$1
GIT_PATH=/git/$APP_NAME
APP_PATH=/apps/$APP_NAME
BRANCH=master

echo "Deploying $APP_NAME"

cd $GIT_PATH

# Deleting old application, except gitgnore files
git ls-files | while read file
do
    rm "$file"
done

# Deploying branch to app directory
git archive $BRANCH | tar -x -f - -C $APP_PATH/

# Install packages
cd $APP_PATH/
npm install --production

echo "Deployed"
