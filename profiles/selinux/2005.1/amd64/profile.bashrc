# fix for bug 60147, "configure causes sandbox violations when lib64
# is a directory". currently only works with cvs portage.
#SANDBOX_WRITE="${SANDBOX_WRITE}:/usr/lib64/conftest:/usr/lib64/cf"
addwrite /usr/lib64/conftest
addwrite /usr/lib64/cf

# oh goodie, yet ANOTHER sandbox bug!!!! >:|
# without portage 2.0.51 and the following entries, at least dbus will spew
# sandbox violations like mad with python in lib64.
addpredict /usr/lib64/python2.0/
addpredict /usr/lib64/python2.1/
addpredict /usr/lib64/python2.2/
addpredict /usr/lib64/python2.3/
addpredict /usr/lib64/python2.4/
addpredict /usr/lib64/python2.5/
addpredict /usr/lib64/python3.0/

# sandbox is disabled for /dev/null by default, so this bug isnt caught.
# hopefully this will help us figure out where this problem occurs...
if [ ! -e /dev/null ] ; then
	eerror "/dev/null doesnt exist! this is bad! tail -n 20 /var/log/emerge.log and attach the output to http://bugs.gentoo.org/show_bug.cgi?id=65876"
	exit 1
elif [ -f /dev/null ] ; then
	eerror "/dev/null is a normal file! this is bad! tail -n 20 /var/log/emerge.log and attach the output to http://bugs.gentoo.org/show_bug.cgi?id=65876"
	exit 1
fi
