# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python/mysql-python-1.1.9.ebuild,v 1.2 2005/01/26 01:47:41 fserb Exp $

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
	if use ssl; then
		export mysqloptlibs="ssl crypto"
	fi
	export mysqlclient="mysqlclient_r"
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