# lib64 sandbox stuff copied from amd64's profile.bashrc:
# fix for bug 60147, "configure causes sandbox violations when lib64
# is a directory". currently only works with cvs portage.

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

export CFLAGS_sparc32
export CFLAGS_sparc64
