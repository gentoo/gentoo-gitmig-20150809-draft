# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/iguanaIR/iguanaIR-0.93.ebuild,v 1.6 2010/11/05 13:41:57 hwoarang Exp $

inherit eutils flag-o-matic

DESCRIPTION="library for Irman control of Unix software"
HOMEPAGE="http://iguanaworks.net/index.php"
SRC_URI="http://iguanaworks.net/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

pkg_setup() {
	append-flags -fPIC
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -e "s:CFLAGS =:CFLAGS ?=:" -i Makefile.in

	epatch "${FILESDIR}"/${P}-gentoo.diff \
		"${FILESDIR}"/${P}-asneeded.patch
}

src_install() {
	emake DESTDIR="${D}" install || die

	insinto /etc/udev/rules.d/
	doins "${FILESDIR}"/40-iguanaIR.rules
}
