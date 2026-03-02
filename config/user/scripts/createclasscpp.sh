#!/bin/bash

# Make sure there is one argument
if [ $# -lt 1 ]; then
    echo 1>&2 "$0: class name not provided"
      exit 2
fi

class_name=$1
header_file="${class_name}.h"
cpp_file="${class_name}.cpp"

# Create header file
cat <<EOF > "$header_file"
#ifndef ${class_name}_H
#define ${class_name}_H

class $class_name {
public:
    $class_name();
    ~$class_name();

};

#endif // ${class_name}_H
EOF

# Create cpp file
cat <<EOF > "$cpp_file"
#include "$header_file"

$class_name::$class_name() {
}

$class_name::~$class_name() {
}

EOF


echo "Created $header_file and $cpp_file in $(pwd)"

# Find CMakeLists.txt in current or parent directory
if [ -f "./CMakeLists.txt" ]; then
    cmake_file="./CMakeLists.txt"
elif [ -f "../CMakeLists.txt" ]; then
    cmake_file="../CMakeLists.txt"
else
    echo "No CMakeLists.txt found in current or parent directory. Skipping CMake edit."
    exit 0
fi

# Add cpp_file to add_executable in CMakeLists.txt
# Assumes the last line is just a closing ')'
sed -i '' -e "\$i\\
  $cpp_file
" "$cmake_file"

echo "Added $cpp_file to $cmake_file"
