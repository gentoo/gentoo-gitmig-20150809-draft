# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3blaster/mp3blaster-3.1.3.ebuild,v 1.6 2003/05/12 20:02:24 weeve Exp $

DESCRIPTION="Command line MP3 player."
HOMEPAGE="http://www.stack.nl/~brama/mp3blaster/"
SRC_URI="http://www.stack.nl/~brama/mp3blaster/src/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ppc ~alpha ~sparc"
LICENSE="GPL-2"
IUSE="oggvorbis mysql"

DEPEND=">=sys-libs/ncurses-5.2
	mysql? ( >=dev-db/mysql-3.23.36 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )"
#	nas? ( >=media-libs/nas-1.4.1 )

src_unpack() {
	unpack ${A}

	#if [ "`use nas`" ]; then
	#	cd src
	#	sed -e "s:^INCLUDES =:INCLUDES = -I/usr/X11R6/include:" \
	#		-e "s:^splay_LDADD =:splay_LDADD = \$(NAS_LIBS):" \
	#		Makefile | cat > Makefile
	#fi
}

src_compile() {
	local myconf
	### Looks like NAS support is broken, at least with NAS 1.5 and
	### mp3player 3.1.1 (Aug 13, agenkin@thpoon.com)
	#use nas && myconf="${myconf} --with-nas"
	#use nas || myconf="${myconf} --disable-nas"
	myconf="${myconf} --disable-nas"
	use mysql && myconf="${myconf} --with-mysql"
	use oggvorbis || myconf="${myconf} --without-oggvorbis"

	econf ${myconf} || die
	make CC="gcc ${CFLAGS}" CXX="c++ ${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO
}
