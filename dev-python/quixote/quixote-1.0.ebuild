# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/quixote/quixote-1.0.ebuild,v 1.6 2007/07/05 01:22:01 hawking Exp $

inherit distutils

MY_P=${P/q/Q}
DESCRIPTION="Python HTML templating framework for developing web applications."
HOMEPAGE="http://www.mems-exchange.org/software/quixote/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~x86 ~ppc ppc-macos"
IUSE=""

DEPEND=">=dev-lang/python-2.2"
S=${WORKDIR}/${MY_P}

src_install() {
	DOCS="ACKS CHANGES"
	distutils_src_install
	dodoc doc/*.txt
	dohtml doc/*.html
	dodir /usr/share/${PN}/demo
	insinto /usr/share/${PN}/demo
	doins demo/*
}
