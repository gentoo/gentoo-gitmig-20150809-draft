# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python/mysql-python-0.9.2-r1.ebuild,v 1.3 2003/04/28 19:55:26 liquidx Exp $

S=${WORKDIR}/MySQL-python-${PV}
DESCRIPTION="MySQL Module for python" 
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
LICENSE="GPL-2"

SLOT="0"
DEPEND="virtual/python
	>=dev-db/mysql-3.22.19"
KEYWORDS="ppc x86 sparc"
IUSE=""

inherit distutils

src_compile() {
    if has_version '>=dev-db/mysql-4.0.10' >& /dev/null
	then
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

