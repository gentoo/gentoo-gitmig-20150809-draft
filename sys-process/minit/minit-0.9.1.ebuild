# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/minit/minit-0.9.1.ebuild,v 1.2 2005/04/16 07:48:31 vapier Exp $

inherit eutils

DESCRIPTION="a small yet feature-complete init"
HOMEPAGE="http://www.fefe.de/minit/"
SRC_URI="http://www.fefe.de/minit/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="diet"

DEPEND="diet? ( dev-libs/dietlibc )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-destdir.patch
	use diet || sed -i -e '/^DIET=diet/d' Makefile
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc CHANGES README TODO
}
