# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livetools/livetools-1.2.3.ebuild,v 1.4 2004/11/12 18:24:51 blubb Exp $

DESCRIPTION="A small set of utilities to allow easy access to Creative's SoundBlaster Live!Drive IR's remote control."
HOMEPAGE="http://www.clarkson.edu/~evanchsa/software/livetools/"
SRC_URI="http://www.clarkson.edu/~evanchsa/software/livetools/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

# Currently, this is only functional as a XMMS plugin
# so it makes no sense to run it without XMMS. When it
# becomes more generalized we can remove the XMMS dep.
DEPEND="media-sound/xmms"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
