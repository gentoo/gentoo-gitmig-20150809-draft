# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbappconf/bbappconf-0.0.2.ebuild,v 1.11 2012/06/04 19:13:14 xmw Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="utility that allows you to specify window properties in blackbox"
HOMEPAGE="http://sourceforge.net/projects/bbtools"
SRC_URI="mirror://sourceforge/bbtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86 ~x86-fbsd"
IUSE="debug"

src_unpack() {
	epatch "${FILESDIR}"/${P}-fix-sigsegv.diff \
		"${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-docs.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO data/README.bbappconf
}
