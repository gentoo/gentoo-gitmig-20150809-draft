# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3blaster/mp3blaster-3.1.1.ebuild,v 1.4 2002/07/21 15:20:12 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="MP3 command line player"
SRC_URI="ftp://mud.stack.nl/pub/mp3blaster/${P}.tar.gz"
HOMEPAGE="http://www.stack.nl/~brama/mp3blaster"

DEPEND=">=sys-libs/ncurses-5.2
	nas? ( >=media-libs/nas-1.4.1 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	local myconf
	use nas && myconf="${myconf} --with-nas"
	use mysql && myconf="${myconf} --with-mysql"
	use oggvorbis || myconf="${myconf} --without-oggvorbis"

	(cd src;patch -l <${FILESDIR}/mp3blaster-3.1.1-gcc3.1-fixes_cl.patch)

	econf ${myconf} || die

	use nas && ( \
		cd src
		sed -e "s:^INCLUDES =:INCLUDES = -I/usr/X11R6/include:" \
			-e "s:^splay_LDADD =:splay_LDADD = \$(NAS_LIBS):" \
			Makefile | cat > Makefile

		cd ${S}
	)

	# parallel make does not work
	make CC="gcc ${CFLAGS}" CXX="c++ ${CXXFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO
}
