# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3blaster/mp3blaster-3.0_p8.ebuild,v 1.2 2001/09/07 02:56:52 woodchip Exp $

A=${PN}-3.0p8.tar.gz
S=${WORKDIR}/${PN}-3.0p8
DESCRIPTION="MP3 command line player"
SRC_URI="ftp://mud.stack.nl/pub/mp3blaster/${A}"
HOMEPAGE="http://www.stack.nl/~brama/mp3blaster"

DEPEND=">=sys-libs/ncurses-5.2
        nas? ( >=media-sound/nas-1.4.1 )
        mysql? ( >=dev-db/mysql-3.23.36 )
        vorbis? ( >=media-libs/libvorbis-1.0_beta1 )"

src_compile() {
	local myconf
	use nas && myconf="${myconf} --with-nas"
	use mysql && myconf="${myconf} --with-mysql"
	use vorbis || myconf="${myconf} --without-oggvorbis"

	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf} || die

	if [ "`use nas`" ] ; then
		cd src
		sed -e "s:^INCLUDES =:INCLUDES = -I/usr/X11R6/include:" \
			-e "s:^splay_LDADD =:splay_LDADD = \$(NAS_LIBS):" Makefile | cat > Makefile
		cd ..
	fi

	# parallel make does not work
	make CC="gcc ${CFLAGS}" CXX="c++ ${CXXFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO
}
