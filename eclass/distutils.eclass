# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/distutils.eclass,v 1.7 2003/03/06 02:47:50 kutsuya Exp $
#
# Author: Jon Nelson <jnelson@gentoo.org>
#
# The distutils eclass is designed to allow easier installation of
# distutils-based python modules, and their incorporation into 
# the Gentoo Linux system.

ECLASS=distutils
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_compile src_install

# This helps make it possible to add extensions to python slots.
if [ "${PYTHON_SLOT_VERSION}" = 2.1 ] ; then 
	newdepend "virtual/python-2.1"
	python="python2.1"
else
	newdepend "virutal/python"
	python="python"
fi

distutils_src_compile() {
	${python} setup.py build || die "compilation failed"
}

distutils_src_install() {
	${python} setup.py install --root=${D} || die
	dodoc CHANGELOG COPYRIGHT KNOWN_BUGS MAINTAINERS
	dodoc CONTRIBUTORS LICENSE COPYING*
	dodoc Change* MANIFEST* README* ${mydoc}
}

# e.g. insinto ${ROOT}/usr/include/python${PYVER}

distutils_python_version()
{
	local tmpstr="$(${python} -V 2>&1 )"
	tmpstr="${tmpstr#Python }"
	tmpstr=${tmpstr%.*}

	PYVER_MAJOR="${tmpstr%.[0-9]*}"
	PYVER_MINOR="${tmpstr#[0-9]*.}"
	PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
}