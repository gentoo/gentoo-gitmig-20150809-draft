# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/f2py/f2py-2.39.235.1693.ebuild,v 1.2 2004/05/02 11:36:44 dholm Exp $

inherit distutils

PN0="F2PY"
PV0="2.39.235_1693"
DESCRIPTION="Fortran to Python interface generator"
HOMEPAGE="http://cens.ioc.ee/projects/f2py2e/"
SRC_URI="http://cens.ioc.ee/projects/f2py2e/2.x/${PN0}-${PV0}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="dev-lang/python
		dev-python/numeric"

S=${WORKDIR}/${PN0}-${PV0}

src_install() {
	distutils_src_install
	dodoc ${S}/docs/{*.txt,hello.f}
	dodir /usr/share/doc/${P}/usersguide
	insinto /usr/share/doc/${P}/usersguide
	doins ${S}/docs/usersguide/*
}
