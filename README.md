# 1hdoc
[![Code Climate](https://codeclimate.com/github/domcorvasce/1hdoc/badges/gpa.svg)](https://codeclimate.com/github/domcorvasce/1hdoc)
[![Test Coverage](https://codeclimate.com/github/domcorvasce/1hdoc/badges/coverage.svg)](https://codeclimate.com/github/domcorvasce/1hdoc/coverage)
[![Build Status](https://travis-ci.org/domcorvasce/1hdoc.svg?branch=master)](https://travis-ci.org/domcorvasce/1hdoc)

Keep track of your progress during #100DaysOfCode event.

## Installation

Install **1hdoc** from RubyGems:

```shell
gem install 1hdoc
```

or clone this repository and build the gem manually:

```shell
git clone https://github.com/domcorvasce/1hdoc
cd 1hdoc

gem build 1hdoc.gemspec
gem install *.gem
```

## Getting Started

### Configure the necessary

Here we are! Now you've to initialize all necessary files which are:
  
  - the [#100DaysOfCode's repository](https://github.com/Kallaway/100-days-of-code)
  - the .1hdoc.yml configuration file

Open your Terminal and type:

```shell
1hdoc init
```

### Change repo's remote origin

A final thing, you should edit the repo's remote origin so I can 
push to your account.

First of all, open GitHub or whatever you use and create a new empty repository.

Now move to the **100-days-of-code** repo's folder and type:

```shell
git remote remove origin
git remote add origin YOUR_REPO_URL
```

Hooray! We're done.

### Register your progress

Have you ended Day 2? 

Great! Let's 1hdoc track your progress. Type:

```shell
1hdoc commit
```

By default, 1hdoc will push to the repo automatically after you 
register your progress. 

You can change this behavior by assigning `false` to `auto_push` option in 
`~/.1hdoc.yml`:

```yaml
workspace: ~/Workspace/Mine/100-days-of-code
auto_push: false
```

### Manually push to the repo

If you turn off `auto_push` you can push to the repo typing:

```shell
1hdoc sync
```

### See progress

Obviously you can see your progress:

```shell
1hdoc log
1hdoc log 2 # only day 2
```

## Contribute

Everyone can contribute to this project:

  - Fixing bugs
  - Fixing my bad english
  - Proposing new features
  - Improving code
  - and doing a plethora of other things..
  
Feel free to open an issue and propose a pull request.

## License

**1hdoc** is released under terms of _GNU/GPL v3_ license.
