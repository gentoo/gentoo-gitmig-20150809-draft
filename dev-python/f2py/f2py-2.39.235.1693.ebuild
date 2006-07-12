# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/f2py/f2py-2.39.235.1693.ebuild,v 1.6 2006/07/12 15:19:11 agriffis Exp $

inherit distutils

PN0="F2PY"
PV0="2.39.235_1693"

S=${WORKDIR}/${PN0}-${PV0}
DESCRIPTION="Fortran to Python interface generator"
HOMEPAGE="http://cens.ioc.ee/projects/f2py2e/"
SRC_URI="http://cens.ioc.ee/projects/f2py2e/2.x/${PN0}-${PV0}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="ia64 ~ppc x86"
IUSE=""
DEPEND="dev-lang/python
	dev-python/numeric"

src_install() {
	distutils_src_install
	dodoc ${S}/docs/{*.txt,hello.f}
	dodir /usr/share/doc/${P}/usersguide
	insinto /usr/share/doc/${P}/usersguide
	doins ${S}/docs/usersguide/*
}

