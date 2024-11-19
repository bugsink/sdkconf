#/bin/bash
set -e

# Set the tag variable and exit if it is not set

if [ -z "$1" ]; then
  echo "Please provide a tag"
  exit 1
fi

TAG=$1

if [ -n "$(git status --porcelain)" ]; then
  echo "Changes detected, I will not release";
  exit 1;
fi


git tag -a $TAG -m "Release $TAG"
git push origin $TAG
git push origin main

# Build the image
python3 -m build .

python -m twine upload dist/sdkconf-$TAG-py3-none-any.whl dist/sdkconf-$TAG.tar.gz
