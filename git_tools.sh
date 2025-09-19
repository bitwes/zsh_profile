#!/bin/bash
git config --global pager.branch false

# alias gitcod='git checkout .'
alias gpo='git push origin HEAD'
# alias gitkey='eval "$(ssh-agent -s)";ssh-add ~/.ssh/git_rsa'
# alias gitsquash='git reset $(git merge-base ${defaultBranch} $(git rev-parse --abbrev-ref HEAD))'

# This shows a diff of changes made on the current branch compared to main.
# I've wanted this forever and this should be one of the first things you are
# ever taught when learning about git.  It should be in BOLD somewhere.
# Between this and the git_branch_log function I might be able to skip looking
# at github diffs to evaluate most of a PR.  This is fantastic.
#
# Also, wtf is this command?  Three dots?  How much of 'git diff' do I have to
# understand in order for this to make sense or to have come up with this on my
# own?  This is why git is dumb.  This is the kind of thing that should be
# easily accessible.
alias git_branch_diff='git diff main...'

#----------------------
#git
#----------------------
alias gitinfo='
echo "Remotes";
echo "-------";
git remote -v;
echo
echo "Branches";
echo "-------";
git branch;
echo
echo "Status"
echo "-------";
git status'

func branch_file(){
  local branch_name=$1
  local file_name=$2

  eval "git show ${branch_name}:${file_name} > ${file_name}"
}

# Shows just a list of commits on the current branch.  It is insane that this
# is not the default for "git log".  There's a f'ing caret (had to look up how
# to spell that again...googled "shift six is a carrot?"...AI told me "No
# Shift + 6 on a keyboard does not produce a carrot" and it had an image of
# some raw carrots that were just dug up and being held aloft like the head of a
# defeated foe, like holding a Madusa head) in this command.
# Example:  git log branch_name ^main --no-merges
function git_branch_log() {
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}

  git log $branch ^main --no-merges
}


# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/
function gh_browser() {
  local remote='origin'
  if [ $1 ]; then
    remote=$1
  fi

  giturl=$(git config --get remote.$remote.url)
  echo $giturl
  if [[ "$giturl" == "" ]]; then
    echo "Not a git repository or no remote.origin.url set"
    return 1;
  fi

  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}

  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree/}
  giturl=$giturl/tree/$branch

  # `open $giturl`
  echo $giturl
  echo $giturl | pbcopy
}

function gh_new_issue(){
  giturl=$(git config --get remote.origin.url)
  giturl=${giturl/\.git/\/issues\/new/}
  `open $giturl`
}

function gh_issues(){
  giturl=$(git config --get remote.origin.url)
  giturl=${giturl/\.git/\/issues/}
  `open $giturl`

}

function origin_to_upstream(){
  `git remote remove upstream`
  `git remote rename origin upstream`
  `git remote add origin $1`
  echo `git remote -v`
}

function upstream_to_origin(){
  `git remote remove origin`
  `git remote rename upstream origin`
  echo `git remote -v`
}

function master_diff(){
  local file=''
  local main="main"

  if [[ $1 ]]; then
    file=`find ./ -iname "$1"`
    match_count=`find ./ -iname "$1" | wc -l`
    echo $match_count
    if [ "$match_count" -eq "1" ]; then
      git diff $main $file
    else
      git diff $main "*$1*"
    fi
  else
    git diff $main
  fi

}

GIT_EXTERNAL_DIFF=$ZSHFILES/bin/git_external_diff
export GIT_EXTERNAL_DIFF

alias hide_git='git config --global oh-my-zsh.hide-status 1'
alias show_git='git config --global oh-my-zsh.hide-status 0'

