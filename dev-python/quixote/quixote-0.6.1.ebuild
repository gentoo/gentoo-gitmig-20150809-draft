# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/quixote/quixote-0.6.1.ebuild,v 1.7 2007/07/05 01:22:01 hawking Exp $

inherit distutils

PN0="Quixote"
DESCRIPTION="Python HTML templating framework for developing web applications."
HOMEPAGE="http://www.mems-exchange.org/software/quixote/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${PN0}-${PV}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"
S=${WORKDIR}/${PN0}-${PV}

src_install() {
	DOCS="ACKS CHANGES"
	distutils_src_install
	dodoc doc/*.txt
	dohtml doc/*.html
	dodir /usr/share/${PN}/demo
	insinto /usr/share/${PN}/demo
	doins demo/*
}
