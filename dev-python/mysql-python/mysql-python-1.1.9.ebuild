# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python/mysql-python-1.1.9.ebuild,v 1.1 2005/01/25 14:31:50 fserb Exp $

inherit distutils

S=${WORKDIR}/MySQL-python-${PV}
DESCRIPTION="MySQL Module for python"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~sparc ~amd64"
IUSE="ssl"

DEPEND="virtual/python
	>=dev-db/mysql-3.22.19
	ssl? ( dev-libs/openssl )"

src_compile() {
	if has_version '>=dev-db/mysql-4.0.10' >& /dev/null ; then
		sed -i 's/thread_safe_library = YES/thread_safe_library = NO/' setup.py
	fi

	if use ssl; then
		export mysqloptlibs="ssl crypto"
	fi
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml doc/*
}

pkg_postinst()
{
	if ! use ssl; then
		echo
		einfo "ssl support may be needed depending on your MySQL server configuration"
		einfo "to re-emerge with ssl support use the ssl USE flag, like:"
		einfo "USE='ssl' emerge ${PN}"
		echo
	fi
}