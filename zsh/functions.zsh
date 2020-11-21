# Extract files of various types
function extract {
  echo Extracting $1 ...
  if [ -f $1 ]; then
      case $1 in
          *.tar.bz2)   tar xjf $1;;
          *.tar.gz)    tar xzf $1;;
          *.bz2)       bunzip2 $1;;
          *.rar)       unrar x $1;;
          *.gz)        gunzip $1;;
          *.tar)       tar xf $1;;
          *.tbz2)      tar xjf $1;;
          *.tgz)       tar xzf $1;;
          *.zip)       unzip $1;;
          *.Z)         uncompress $1;;
          *.7z)        7z x $1;;
          *)           echo "'$1' cannot be extracted via extract()";;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

# The citrix workspace app I need for work has no option to disable starting
# at login. I rarely need it, so these functions allow for removing from and
# re-adding to launchctl.
function addcitrix {
  launchctl load -w /Library/LaunchAgents/com.citrix.ServiceRecords.plist
  launchctl load -w /Library/LaunchAgents/com.citrix.ReceiverHelper.plist
  launchctl load -w /Library/LaunchAgents/com.citrix.AuthManager_Mac.plist
}

function removecitrix {
  launchctl remove com.citrix.ServiceRecords
  launchctl remove com.citrix.ReceiverHelper
  launchctl remove com.citrix.AuthManager_Mac
}
