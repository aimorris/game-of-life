spago test || { exit 1; }

if [ ! -d dist/ ]; then
  mkdir -p dist/
fi

cat << EOF > dist/index.html
<!DOCTYPE html>
<html>
  <head>
    <style>
      * {
        margin: 0;
        padding: 0;
        background: #222;
        color: #eee;
        text-align: center;
      }
      
      body {
        font-size: 1.5em;
      }
      
      h1 {
        padding-bottom: 1em;
      }
    </style>
  </head>
  <body>
    <h1>List of life</h1>
    <ul>
EOF

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

cat << EOF >> dist/index.html
      <li><a href="life/$filename/index.html">$filename</a></li>
EOF

  cat src/site/life.html > dist/life/$filename/index.html

  spago bundle-app -m $modulename -t dist/life/$filename/index.js
done

cat << EOF >> dist/index.html
    </ul>
  </body>
</html>
EOF