

# Why?

It's annoying to lookup new repos on GitHub only to see instructions like:
```sh
pip install -r requirements.txt
```

Where am I supposed to install all these packages into?

Possibly there will be an instruction like:
```sh
python -m venv venv
source ./venv/bin/activate
pip install -r requirements.txt
```

But if the first line's executable `python` is a wrong Python version? How can I change that? It's just so annoying.

Or they might write `python3.11 -m venv venv`. But if my system does not have `python3.11`?

Don't you wish there would be an easier way to download not only Python packages separately for each GitHub repo you clone, but also manage their versions, and the version of Python itself, in an easy out-of-the-box way?

# Enter: python-deployer

`python-deployer` is an easy answer to the above questions. In short, just do something like:

```sh
git clone https://github.com/dimitri-rusin/python-deployer.git

git clone https://github.com/ferdinandvanwyk/pyfilm # this can be any other GitHub repo with an annoying `pip install -r requirements.txt` instruction
cd pyfilm

# This is the magic command that manages a Python environment for you
../python-deployer/DEPLOY .

# Adapt .python/pip.txt
.python/BUILD
# Adapt .python/RUN
.python/RUN
```

The Python environment that you create with `../python-deployer/DEPLOY .` consists of:
- Miniconda3 that lets you adapt your Python version, just go to the file `.python/Miniconda3.yaml`
- A `pip.txt` file, where you can adapt your Python packages and their versions.
- Everything is completely contained within a repo-private `.python` folder, just download all the Python packages again for another GitHub repo (so they can have different versions of `numpy` etc.)

You have downloaded a fresh Miniconda3 binary just for this GitHub repo. If you want to activate the repo using this Miniconda3 binary, if you use bash, go:
```sh
eval "$(.python/Miniconda3/bin/conda shell.bash hook)"
conda activate .python/venv/
```

Forgot your Python package version? Just run `python .python/align_pip.py` and current package versions will be written into the `pip.txt`.

GO NUTS!! :)

# More features

You can also do
```sh
./python-deployer/BUILD --verbose
```
This will get you a lot of information about what's going on during the installation of the Python binary and packages.


Or:
```sh
./python-deployer/RUN --verbose
```
