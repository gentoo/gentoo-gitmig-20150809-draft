# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.0.1.ebuild,v 1.3 2002/07/21 03:07:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based Audio CD Ripper"
SRC_URI="http://www.nostatic.org/grip/${P}.tar.gz"
HOMEPAGE="http://www.nostatic.org/grip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	=sys-libs/db-1*
	media-sound/lame
	media-sound/cdparanoia
	media-libs/id3lib
	gnome-base/gnome-libs
	gnome-base/ORBit
	gnome-base/libghttp
	oggvorbis? ( media-sound/vorbis-tools )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	# apply CFLAGS
	mv Makefile.in Makefile.in.old
	sed -e "s/CFLAGS = -g -O2/CFLAGS = ${CFLAGS}/" \
		Makefile.in.old > Makefile.in

	# fix cdparanoia libs not linking
	mv src/Makefile.in src/Makefile.in.orig
	sed -e "s/LDFLAGS =/LDFLAGS = -lcdda_interface -lcdda_paranoia/" \
		src/Makefile.in.orig > src/Makefile.in

	econf ${myconf} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		install || die

	dodoc AUTHORS CREDITS COPYING ChangeLog README TODO NEWS
}
