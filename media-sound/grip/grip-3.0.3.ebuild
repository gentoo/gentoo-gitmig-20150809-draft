# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.0.3.ebuild,v 1.8 2004/03/30 17:57:27 eradicator Exp $

IUSE="nls oggvorbis"

DESCRIPTION="GTK+ based Audio CD Player/Ripper."
HOMEPAGE="http://www.nostatic.org/grip"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc"

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

SRC_URI="http://www.nostatic.org/grip/${P}.tar.gz"

# Looks like the Makefile.in mangling is no longer required.
# Arcady Genkin <agenkin@gentoo.org>, Sep 26, 2002.
#
#src_unpack() {
#
#	unpack ${A}
#	cd ${S}
#	 
#	# apply CFLAGS
#	mv Makefile.in Makefile.in.old
#	sed -e "s/CFLAGS = -g -O2/CFLAGS = ${CFLAGS}/" \
#		Makefile.in.old > Makefile.in
#
#	# fix cdparanoia libs not linking
#	mv src/Makefile.in src/Makefile.in.orig
#	sed -e "s/LDFLAGS =/LDFLAGS = -lcdda_interface -lcdda_paranoia/" \
#		src/Makefile.in.orig > src/Makefile.in
#}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die

	dodoc ABOUT-NLS AUTHORS CREDITS COPYING ChangeLog README TODO NEWS
}
