#!/usr/bin/env bash
# Run this from the ROOT of your alu-higher_level_programming repo:
#   bash setup_js_warmup.sh
set -e

mkdir -p javascript-warm_up
cd javascript-warm_up

cat > 0-javascript_is_amazing.js << 'EOF'
#!/usr/bin/node
const myVar = 'JavaScript is amazing';
console.log(myVar);
EOF

cat > 1-multi_languages.js << 'EOF'
#!/usr/bin/node
console.log('C is fun');
console.log('Python is cool');
console.log('JavaScript is amazing');
EOF

cat > 2-arguments.js << 'EOF'
#!/usr/bin/node
const count = process.argv.length - 2;
if (count === 0) {
  console.log('No argument');
} else if (count === 1) {
  console.log('Argument found');
} else {
  console.log('Arguments found');
}
EOF

cat > 3-value_argument.js << 'EOF'
#!/usr/bin/node
const arg = process.argv[2];
if (arg === undefined) {
  console.log('No argument');
} else {
  console.log(arg);
}
EOF

cat > 4-concat.js << 'EOF'
#!/usr/bin/node
console.log(`${process.argv[2]} is ${process.argv[3]}`);
EOF

cat > 5-to_integer.js << 'EOF'
#!/usr/bin/node
const num = parseInt(process.argv[2]);
if (isNaN(num)) {
  console.log('Not a number');
} else {
  console.log(`My number: ${num}`);
}
EOF

cat > 6-multi_languages_loop.js << 'EOF'
#!/usr/bin/node
const langs = ['C is fun', 'Python is cool', 'JavaScript is amazing'];
for (let i = 0; i < langs.length; i++) {
  console.log(langs[i]);
}
EOF

cat > 7-multi_c.js << 'EOF'
#!/usr/bin/node
const x = parseInt(process.argv[2]);
if (isNaN(x)) {
  console.log('Missing number of occurrences');
} else {
  for (let i = 0; i < x; i++) {
    console.log('C is fun');
  }
}
EOF

cat > 8-square.js << 'EOF'
#!/usr/bin/node
const size = parseInt(process.argv[2]);
if (isNaN(size)) {
  console.log('Missing size');
} else {
  for (let i = 0; i < size; i++) {
    console.log('X'.repeat(size));
  }
}
EOF

cat > 9-add.js << 'EOF'
#!/usr/bin/node
function add (a, b) {
  return a + b;
}
console.log(add(parseInt(process.argv[2]), parseInt(process.argv[3])));
EOF

cat > 10-factorial.js << 'EOF'
#!/usr/bin/node
function factorial (n) {
  if (isNaN(n) || n <= 1) {
    return 1;
  }
  return n * factorial(n - 1);
}
console.log(factorial(parseInt(process.argv[2])));
EOF

cat > 11-second_biggest.js << 'EOF'
#!/usr/bin/node
const nums = process.argv.slice(2).map(Number);
if (nums.length < 2) {
  console.log(0);
} else {
  nums.sort((a, b) => b - a);
  console.log(nums[1]);
}
EOF

cat > 12-object.js << 'EOF'
#!/usr/bin/node
const myObject = {
  type: 'object',
  value: 12
};
console.log(myObject);
myObject.value = 89;
console.log(myObject);
EOF

cat > 13-add.js << 'EOF'
#!/usr/bin/node
exports.add = function (a, b) {
  return a + b;
};
EOF

# Add a README if there isn't one
[ -f README.md ] || echo "# JavaScript warm up" > README.md

chmod +x ./*.js

# Commit with the executable bit saved, then push
git add ./*.js README.md
git update-index --chmod=+x ./*.js
git commit -m "Add javascript-warm_up tasks 0-13"
git push

echo "Done. Quick tests:"
./2-arguments.js Best School
./5-to_integer.js 89.89
./8-square.js 2
./10-factorial.js 3
./11-second_biggest.js 4 2 5 3 0 -3
