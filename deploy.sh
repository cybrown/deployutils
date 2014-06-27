#!/bin/sh

APP_NAME=$1
GIT_PATH=/git/$APP_NAME
APP_PATH=/apps/$APP_NAME

echo "Deploying $APP_NAME"

# Saving node_modules
if [ -d $APP_PATH/node_modules ]
then
    mv $APP_PATH/node_modules /tmp/node_modules_$APP_NAME
fi

# Deleting old application
rm -rf $APP_PATH/*

# Deploying master branch to app directory
cd $GIT_PATH
git archive master | tar -x -f - -C $APP_PATH/

# Restoring node_modules
if [ -d /tmp/node_modules_$APP_NAME ]
then
    mv /tmp/node_modules_$APP_NAME $APP_PATH/node_modules
fi

# Install packages
cd $APP_PATH/
npm install

echo "Deployed"
