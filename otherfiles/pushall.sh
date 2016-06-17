#! /bin/bash -x

cd npf
git add --all
git commit -m "update $(date)"
git push rushiagr master
cd public
git add --all
git commit -m "update $(date)"
git push origin master
