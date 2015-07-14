export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

##
# Your previous /Users/uri/.bash_profile file was backed up as /Users/uri/.bash_profile.macports-saved_2009-10-24_at_00:27:33
##

# MacPorts Installer addition on 2009-10-24_at_00:27:33: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH

# Setting PATH for MacPython 2.6
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
#export PATH

export PYTHONPATH=${PYTHONPATH}:${HOME}/NYU/Dissertation/

if [ -f ~/.bashrc ]; then
	   source ~/.bashrc
fi
export WWISESDK=/Users/uri/Wwise/Wwise_v2014.1.5_build_5282/SDK
