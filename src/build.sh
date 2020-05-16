for file in src/life/*; do
  filename=$(basename -s ".purs" $file)
  modulename=$(head -n 1 "$file" | sed -n 's/module \(.[^ ]*\).*/\1/p')

  mkdir dist/life
  mkdir dist/life/$filename

  cat dist/life.html > dist/life/$filename/index.html

  spago bundle-app -m $modulename -t dist/life/$filename/index.js
done