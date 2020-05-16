spago test || { exit 1; }

for file in src/life/*; do
  filename=$(basename -s ".purs" $file)
  modulename=$(head -n 1 "$file" | sed -n 's/module \(.[^ ]*\).*/\1/p')

  if [ ! -d "dist" ]; then
    mkdir dist
  fi

  if [ ! -d "dist/life" ]; then
    mkdir dist/life
  fi

  if [ ! -d "dist/life/$filename" ]; then
    mkdir dist/life/$filename
  fi

  cat src/site/life.html > dist/life/$filename/index.html

  spago bundle-app -m $modulename -t dist/life/$filename/index.js
done