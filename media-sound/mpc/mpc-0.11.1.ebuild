# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.11.1.ebuild,v 1.4 2004/09/03 17:03:47 eradicator Exp $

IUSE=""

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"
HOMEPAGE="http://www.musicpd.org"

KEYWORDS="x86 ~ppc sparc amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc"

src_compile() {
	local myconf
	myconf="--with-gnu-ld"

	econf ${myconf} || die "could not configure"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR=${D} || die
	rm -rf ${D}/usr/share/doc/mpc/
	dodoc AUTHORS COPYING ChangeLog INSTALL README doc/mpc-bashrc
}
