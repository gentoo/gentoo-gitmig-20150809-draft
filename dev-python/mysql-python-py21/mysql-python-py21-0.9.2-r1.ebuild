# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python-py21/mysql-python-py21-0.9.2-r1.ebuild,v 1.5 2003/06/26 17:03:27 kutsuya Exp $
PYTHON_SLOT_VERSION="2.1"

inherit distutils
S="${WORKDIR}/MySQL-python-${PV}"

DESCRIPTION="MySQL Module for python" 
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/glibc
	>=dev-db/mysql-3.22.19
	${DEPEND}"
RDEPEND="${DEPEND}${RDEPEND}"
KEYWORDS="x86 ppc"
IUSE=""

src_compile() 
{
    if has_version '>=dev-db/mysql-4.0.10' >& /dev/null ; then
		mv setup.py setup.orig
		sed -e 's/thread_safe_library = YES/thread_safe_library = NO/' \
		setup.orig > setup.py
    fi
    distutils_src_compile
}

src_install() 
{
	distutils_src_install
	dohtml doc/*
}

