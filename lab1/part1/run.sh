#! /bin/bash

# Create directories
echo "Creating needed directories for lab"
./provided/make_dirs.sh

# Ensure creation of aliases
echo "Creating aliases"
./provided/make_aliases.sh

# Run lab
./provided/capture_submission.sh

# Move captures
dt=$(date +"%Y-%m-%d_%H-%M-%S")
sub="submission_$dt"
mkdir "$sub"
mv submission.tgz "$sub"
for f in submission
do
  mv $f "$sub"
done
echo "Moved captures to directory $sub"

# cleanup
echo "Cleaning up"
./rm_dirs.sh
