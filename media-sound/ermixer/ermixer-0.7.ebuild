# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/ermixer/ermixer-0.7.ebuild,v 1.2 2002/07/25 05:38:34 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A Full Featured Audio Mixer"
SRC_URI="http://erevan.cuore.org/files/ermixer/${P}.tar.bz2"
HOMEPAGE="http://ermixer.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
