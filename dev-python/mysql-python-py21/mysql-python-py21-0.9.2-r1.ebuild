# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python-py21/mysql-python-py21-0.9.2-r1.ebuild,v 1.8 2004/04/15 20:23:13 mr_bones_ Exp $

PYTHON_SLOT_VERSION="2.1"

inherit distutils

S="${WORKDIR}/MySQL-python-${PV}"

DESCRIPTION="MySQL Module for python"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/glibc
	>=dev-db/mysql-3.22.19"

src_compile() {
	if has_version '>=dev-db/mysql-4.0.10' >& /dev/null ; then
		mv setup.py setup.orig
		sed -e 's/thread_safe_library = YES/thread_safe_library = NO/' \
		setup.orig > setup.py
	fi
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml doc/*
}
