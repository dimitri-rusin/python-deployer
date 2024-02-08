#!/usr/bin/fish

# Check if no arguments were passed to the script
if test (count $argv) -eq 0
  # Display error message and exit if no arguments are given
  echo "Error: No directory name provided."
  exit 1
end

# Define the new project directory path
set project_dir /home/dimitri/code/$argv[1]

# Create the new project directory
mkdir $project_dir

# Change into the newly created directory
cd $project_dir

# Copy specified files from the source directory to the current directory
cp ~/Softwareentwicklung/setup/.template/{.BUILD,.conda.yaml,.gitignore,.pip.txt,.RUN,.workstory.md} ./

# Grant execute permissions to the .BUILD and .RUN files
chmod u+x ./.BUILD ./.RUN

# Create a new Sublime Text project file
set project_file "/home/dimitri/Softwareentwicklung/Sublime Text Projects/$argv[1].sublime-project"

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
