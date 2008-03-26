# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/iguanaIR/iguanaIR-0.93.ebuild,v 1.1 2008/03/26 17:04:17 hd_brummy Exp $

inherit eutils flag-o-matic

DESCRIPTION="library for Irman control of Unix software"
SRC_URI="http://iguanaworks.net/downloads/${P}.tar.bz2"
HOMEPAGE="http://iguanaworks.net/index.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

pkg_setup() {
	append-flags -fPIC
}

src_unpack() {

	unpack ${A}
	cd "${S}"

	sed -e "s:CFLAGS =:CFLAGS ?=:" -i Makefile.in

	epatch "${FILESDIR}/${P}-gentoo.diff"
}

src_install() {

	emake install DESTDIR="${D}" || die "emake failed"

	insinto /etc/udev/rules.d/
	doins "${FILESDIR}"/40-iguanaIR.rules
}
