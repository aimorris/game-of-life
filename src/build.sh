for file in src/life/*; do
  spago bundle-app -m $(head -n 1 "$file" | sed -n 's/module \(.[^ ]*\).*/\1/p') -t dist/$file
done