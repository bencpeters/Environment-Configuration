# Default OS X PATH:
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

export MANPATH=/opt/local/man:$MANPATH:/opt/local/share/man
export DISPLAY=:0.0

# Setting PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

#Setup Path variable 
for p in \
    /usr/local/bin \
    /usr/local/sbin \
    /opt/local/bin \
    /opt/local/sbin \
    /usr/local/mysql/bin \
    ; do
    [ -x $p ] && PATH=$p:$PATH
done
unset p
export PATH=${PATH##:}:.

export INFOPATH=$INFOPATH:/opt/local/share/info
export DYLB_LIBRARY_PATH=/usr/local/boost_1_48_0/lib

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
