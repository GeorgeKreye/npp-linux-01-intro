#! /bin/bash

# Create directories
echo "Creating needed directories for lab"
./provided/make_dirs.sh

# Warning about aliases
echo "WARNING: Script will not function properly if aliases are not created. If unindended behavior occurs, run ./provided/make_aliases.sh to add needed aliases to bashrc and try again."

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
sudo rm -r clab-lab1-part1
