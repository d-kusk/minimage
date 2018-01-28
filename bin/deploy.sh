set -e

if [[ "false" != "$TRAVIS_PULL_REQUEST" ]]; then
	echo "Not deploying pull requests."
	exit
fi

if [[ "develop" != "$TRAVIS_BRANCH" ]]; then
	echo "Not on the 'develop' branch."
	exit
fi

git checkout -b review

git checkout .
rm -rf node_modules/ tasks/ source/
rm -rf .editorconfig .travis.yml package.json package-lock.json .babelrc webpack.config.babel.js gulpfile.babel.js config.js .gitignore

git config user.name "Travis CI"
git config user.email "travis@example.com"
git add -A
git commit --quiet -m "Deploy from travis"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" review > /dev/null 2>&1
