# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbappconf/bbappconf-0.0.2.ebuild,v 1.8 2006/12/07 02:20:52 flameeyes Exp $

inherit eutils

DESCRIPTION="utility that allows you to specify window properties in blackbox"
HOMEPAGE="http://bbtools.windsofstorm.net/"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86 ~x86-fbsd"
IUSE="debug"

DEPEND="virtual/blackbox"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix-sigsegv.diff
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO
}
