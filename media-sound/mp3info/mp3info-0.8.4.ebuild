# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Claes Nästen <pekdon@gmx.net>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3info/mp3info-0.8.4.ebuild,v 1.2 2002/05/23 06:50:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An MP3 technical info viewer and ID3 1.x tag editor"
SRC_URI="ftp://ftp.ibiblio.org/pub/linux/apps/sound/mp3-utils/${PN}/${P}.tgz"
HOMEPAGE="http://ibiblio.org/mp3info/"

DEPEND="virtual/glibc
	gtk? ( =x11-libs/gtk+-1.2* )"


src_unpack() {

	unpack ${A}
	
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {

	emake mp3info || die
	use gtk && emake gmp3info || die
}

src_install() {

	dobin mp3info
	use gtk && dobin gmp3info
	
	dodoc ChangeLog INSTALL LICENSE README
	doman mp3info.1
}
