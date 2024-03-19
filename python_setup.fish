#!/usr/bin/fish

# Check if no arguments were passed to the script
if test (count $argv) -eq 0
  # Display error message and exit if no arguments are given
  echo "Error: No directory name provided."
  exit 1
end

# Define the new project directory path
set project_dir $HOME/code/$argv[1]

# Create the new project directory
mkdir $project_dir

# Change into the newly created directory
cd $project_dir

# Initialize Git repository
git init

mkdir .deploy/

# Copy specified files from the source directory to the current directory
cp $HOME/code/deploy/BUILD .deploy/BUILD
cp $HOME/code/deploy/conda.yaml .deploy/conda.yaml
cp $HOME/code/deploy/gitignore .gitignore
cp $HOME/code/deploy/pip.txt .deploy/pip.txt
cp $HOME/code/deploy/RUN .deploy/RUN
cp $HOME/code/deploy/workstory.md .deploy/workstory.md

# Grant execute permissions to the .BUILD and .RUN files
chmod u+x .deploy/BUILD .deploy/RUN

# Create a new Sublime Text project file
set project_file "$HOME/Softwareentwicklung/Sublime Text Projects/$argv[1].sublime-project"

# Write the project file content
echo '{
  "folders":
  [
    {
      "path": "'$project_dir'"
    }
  ]
}' > $project_file

subl $project_file
