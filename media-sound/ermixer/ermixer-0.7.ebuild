# Copyright 2002 Michele Balistreri <brain87@gmx.net>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/ermixer/ermixer-0.7.ebuild,v 1.1 2002/07/24 04:21:29 agenkin Exp $

DESCRIPTION="A Full Featured Audio Mixer"
HOMEPAGE="http://ermixer.sourceforge.net"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.2"

SRC_URI="http://erevan.cuore.org/files/ermixer/${P}.tar.bz2"
S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
