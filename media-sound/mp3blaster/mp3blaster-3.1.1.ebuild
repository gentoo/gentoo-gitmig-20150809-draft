# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3blaster/mp3blaster-3.1.1.ebuild,v 1.11 2003/05/12 20:02:24 weeve Exp $

DESCRIPTION="Command line MP3 player."
HOMEPAGE="http://www.stack.nl/~brama/mp3blaster/"
SRC_URI="ftp://mud.stack.nl/pub/mp3blaster/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc alpha ~sparc"
IUSE="nas oggvorbis mysql"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.2
	nas? ( >=media-libs/nas-1.4.1 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )"

src_compile() {
	local myconf
	### Looks like NAS support is broken, at least with NAS 1.5 and
	### mp3player 3.1.1 (Aug 13, agenkin@thpoon.com)
	#use nas && myconf="${myconf} --with-nas"
	myconf="${myconf} --disable-nas"
	use mysql && myconf="${myconf} --with-mysql"
	use oggvorbis || myconf="${myconf} --without-oggvorbis"

	(cd src;patch -l <${FILESDIR}/mp3blaster-3.1.1-gcc3.1-fixes_cl.patch)

	econf ${myconf} || die

	### See comment above
	#use nas && ( \
	#	cd src
	#	sed -e "s:^INCLUDES =:INCLUDES = -I/usr/X11R6/include:" \
	#		-e "s:^splay_LDADD =:splay_LDADD = \$(NAS_LIBS):" \
	#		Makefile | cat > Makefile
	#
	#	cd ${S}
	#)

	# parallel make does not work
	make CC="gcc ${CFLAGS}" CXX="c++ ${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO
}
