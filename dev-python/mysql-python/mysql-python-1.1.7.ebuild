# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python/mysql-python-1.1.7.ebuild,v 1.1 2004/12/05 17:27:39 kloeri Exp $

inherit distutils

S=${WORKDIR}/MySQL-python-${PV}
DESCRIPTION="MySQL Module for python"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~sparc ~amd64"
IUSE=""

DEPEND="virtual/python
	>=dev-db/mysql-3.22.19"

src_compile() {
	if has_version '>=dev-db/mysql-4.0.10' >& /dev/null ; then
		sed -i 's/thread_safe_library = YES/thread_safe_library = NO/' setup.py
	fi
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml doc/*
}
