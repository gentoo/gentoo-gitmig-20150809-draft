# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbisgain/vorbisgain-0.32.ebuild,v 1.8 2004/07/14 21:07:19 agriffis Exp $

IUSE=""

DESCRIPTION="vorbisgain calculates a percieved sound level of an Ogg Vorbis file using the ReplayGain algorithm and stores it in the file header"
HOMEPAGE="http://sjeng.sourceforge.net/ftp/vorbis/"
SRC_URI="http://sjeng.sourceforge.net/ftp/vorbis/${P}.zip"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86"

DEPEND=">=media-libs/libvorbis-1.0_beta4
		app-arch/unzip"

src_unpack() {
	unpack ${P}.zip
	cd ${S}

	cp Makefile.am Makefile.am~
	sed -e s\/"mandir = @MANDIR@"\/"mandir = @mandir@"/ Makefile.am~ > Makefile.am

	cp Makefile.in Makefile.in~
	sed -e s\/"mandir = @MANDIR@"\/"mandir = @mandir@"/ Makefile.in~ > Makefile.in
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
