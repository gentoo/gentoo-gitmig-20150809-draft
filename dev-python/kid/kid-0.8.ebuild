# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kid/kid-0.8.ebuild,v 1.2 2006/03/17 14:12:52 deltacow Exp $

inherit distutils eutils

DESCRIPTION="A simple and Pythonic XML template language"
SRC_URI="http://kid.lesscode.org/dist/${PV}/${P}.tar.gz"
HOMEPAGE="http://kid.lesscode.org/"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/elementtree-1.2.6"


src_unpack() {
	unpack ${A}
	cd ${S} || die "Failed to unpack ${A}"
	#Use distutils instead of egg
	epatch ${FILESDIR}/${P}-ezsetup-gentoo.patch
}

src_install() {
	distutils_src_install
	dohtml -r doc/html/*
	cp -r examples ${D}/usr/share/doc/${PF}
}

pkg_postinst() {
	einfo "Installing dev-python/celementtree may enhance performance."
}

