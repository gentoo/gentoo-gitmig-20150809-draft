# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/python.eclass,v 1.13 2004/01/18 01:32:35 liquidx Exp $
#
# Author: Alastair Tse <liquidx@gentoo.org>
#
# A Utility Eclass that should be inherited by anything that deals with
# Python or Python modules.
#
# - Features:
# python_version()        - sets PYVER/PYVER_MAJOR/PYVER_MINOR
# python_tkinter_exists() - Checks for tkinter support in python
# python_mod_exists()     - Checks if a python module exists
# python_mod_compile()    - Compiles a .py file to a .pyc/.pyo
# python_mod_optimize()   - Generates .pyc/.pyo precompiled scripts
# python_mod_cleanup()    - Goes through /usr/lib/python* to remove
#                           orphaned *.pyc *.pyo
# python_makesym()        - Makes /usr/bin/python symlinks

inherit alternatives

ECLASS="python"
INHERITED="$INHERITED $ECLASS"

#
# name:   python_disable/enable_pyc
# desc:   tells python not to automatically recompile modules to .pyc/.pyo
#         even if the timestamps/version stamps don't match. this is
#         done to protect sandbox.
#
# note:   supported by >=dev-lang/python-2.2.3-r3 only.
#
python_disable_pyc() {
	export PYTHON_DONTCOMPILE=1
}

python_enable_pyc() {
	unset PYTHON_DONTCOMPILE
}

python_disable_pyc

#
# name:   python_version
# desc:   run without arguments and it will export the version of python
#         currently in use as $PYVER
#
python_version() {
	local tmpstr
	python=${python:-/usr/bin/python}
	tmpstr="$(${python} -V 2>&1 )"
	export PYVER_ALL="${tmpstr#Python }"

	export PYVER_MAJOR=$(echo ${PYVER_ALL} | cut -d. -f1)
	export PYVER_MINOR=$(echo ${PYVER_ALL} | cut -d. -f2)
	export PYVER_MICRO=$(echo ${PYVER_ALL} | cut -d. -f3-)
	export PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
}

#
# name:   python_makesym
# desc:   run without arguments, it will create the /usr/bin/python symlinks
#         to the latest installed version
#
python_makesym() {
	alternatives_auto_makesym "/usr/bin/python" "python[0-9].[0-9]"
	alternatives_auto_makesym "/usr/bin/python2" "python2.[0-9]"
}

#
# name:   python_tkinter_exists
# desc:   run without arguments, it will return TRUE(0) if python is compiled
#         with tkinter or FALSE(1) if python is compiled without tkinter.
#
python_tkinter_exists() {
	if ! python -c "import Tkinter" >/dev/null 2>&1; then
		eerror "You need to recompile python with Tkinter support."
		eerror "That means: USE='tcltk' emerge python"
		echo
		die "missing tkinter support with installed python"
	fi
}

#
# name:   python_mod_exists
# desc:   run with the module name as an argument. it will check if a
#         python module is installed and loadable. it will return
#         TRUE(0) if the module exists, and FALSE(1) if the module does
#         not exist.
# exam:
#         if python_mod_exists gtk; then
#             echo "gtk support enabled
#         fi
#
python_mod_exists() {
	if ! python -c "import $1" >/dev/null 2>&1; then
		return 1
	fi
	return 0
}

#
# name:   python_mod_compile
# desc:   given a filename, it will pre-compile the module's .pyc and .pyo.
#         should only be run in pkg_postinst()
# exam:
#         python_mod_compile ${ROOT}usr/lib/python2.3/site-packages/pygoogle.py
#
python_mod_compile() {
	# allow compiling for older python versions
	if [ -n "${PYTHON_OVERRIDE_PYVER}" ]; then
		PYVER=${PYTHON_OVERRIDE_PYVER}
	else
		python_version
	fi

	if [ -f "$1" ]; then
		python${PYVER} -c "import py_compile; py_compile.compile('${1}')" || \
			ewarn "Failed to compile ${1}"
		python${PYVER} -O -c "import py_compile; py_compile.compile('${1}')" || \
			ewarn "Failed to compile ${1}"
	else
		ewarn "Unable to find ${1}"
	fi
}

#
# name:   python_mod_optimize
# desc:   if no arguments supplied, it will recompile all modules under
#         sys.path (eg. /usr/lib/python2.3, /usr/lib/python2.3/site-packages/ ..)
#         no recursively
#
#         if supplied with arguments, it will recompile all modules recursively
#         in the supplied directory
# exam:
#         python_mod_optimize ${ROOT}usr/share/codegen
#
python_mod_optimize() {
	local myroot
	# strip trailing slash
	myroot=$(echo ${ROOT} | sed 's:/$::')

	# allow compiling for older python versions
	if [ -n "${PYTHON_OVERRIDE_PYVER}" ]; then
		PYVER=${PYTHON_OVERRIDE_PYVER}
	else
		python_version
	fi

	# set opts
	if [ "${PYVER}" = "2.2" ]; then
		compileopts=""
	else
		compileopts="-q"
	fi

	ebegin "Byte compiling python modules for python-${PYVER} .."
	python${PYVER} ${myroot}/usr/lib/python${PYVER}/compileall.py ${compileopts} $@
	python${PYVER} -O ${myroot}/usr/lib/python${PYVER}/compileall.py ${compileopts} $@
	eend $?
}

#
# name:   python_mod_cleanup
# desc:   run with optional arguments, where arguments are directories of
#         python modules. if none given, it will look in /usr/lib/python[0-9].[0-9]
#
#         it will recursively scan all compiled python modules in the directories
#         and determine if they are orphaned (eg. their corresponding .py is missing.)
#         if they are, then it will remove their corresponding .pyc and .pyo
#
python_mod_cleanup() {
	local SEARCH_PATH myroot
	
	# strip trailing slash
	myroot=$(echo ${ROOT} | sed 's:/$::')

	if [ $# -gt 0 ]; then
		for path in $@; do
			SEARCH_PATH="${SEARCH_PATH} ${myroot}/${path#/}"
		done
	else
		for path in ${myroot}/usr/lib/python*/site-packages; do
			SEARCH_PATH="${SEARCH_PATH} ${path}"
		done
	fi

	for path in ${SEARCH_PATH}; do
		einfo "Cleaning orphaned Python bytecode from ${path} .."
		for obj in $(find ${path} -name *.pyc); do
			src_py="$(echo $obj | sed 's:c$::')"
			if [ ! -f "${src_py}" ]; then
				einfo "Purging ${src_py}[co]"
				rm -f ${src_py}[co]
			fi
		done
		# attempt to remove directories that maybe empty
		for dir in $(find ${path} -type d | sort -r); do
			rmdir ${dir} 2>/dev/null
		done
	done
}


