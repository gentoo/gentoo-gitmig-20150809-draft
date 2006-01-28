# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnut/gnut-0.4.28-r1.ebuild,v 1.8 2006/01/28 13:16:10 mkay Exp $

inherit eutils

DESCRIPTION="Text-mode gnutella client"
SRC_URI="http://alge.anart.no/ftp/pub/gnutella/${P}.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2"
HOMEPAGE="http://www.gnutelliums.com/linux_unix/gnut/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch configure.patch
	epatch src.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dohtml doc/*.html
	dodoc 	doc/TUTORIAL AUTHORS COPYING ChangeLog GDJ HACKING \
		INSTALL NEWS README TODO
}
