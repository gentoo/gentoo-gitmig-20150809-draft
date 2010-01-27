# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python/mysql-python-1.2.0-r1.ebuild,v 1.13 2010/01/27 19:26:55 armin76 Exp $

inherit distutils eutils

S=${WORKDIR}/MySQL-python-${PV}
DESCRIPTION="MySQL Module for python"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86"

IUSE=""

DEPEND="dev-lang/python
	virtual/mysql"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-newdecimal.patch
}

src_compile() {
	export mysqlclient="mysqlclient_r"
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dohtml doc/*
}
