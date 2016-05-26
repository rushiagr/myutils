#!/bin/bash -eux

cd npf
hugo
cd public
cp blog/index.html index.html
cd ../..

cd npfpersonal
hugo
cd public
cp blog/index.html index.html
cd ..
cp -r public/* ../npf/public/personal/
cd ..
