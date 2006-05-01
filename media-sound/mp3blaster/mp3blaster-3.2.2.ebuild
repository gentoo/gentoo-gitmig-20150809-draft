# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3blaster/mp3blaster-3.2.2.ebuild,v 1.3 2006/05/01 22:37:46 weeve Exp $

inherit toolchain-funcs

DESCRIPTION="Command line MP3 player."
HOMEPAGE="http://mp3blaster.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
LICENSE="GPL-2"
IUSE="lirc mysql vorbis"

DEPEND=">=sys-libs/ncurses-5.2
	mysql? ( >=dev-db/mysql-3.23.36 )
	lirc? ( app-misc/lirc )
	vorbis? ( >=media-libs/libvorbis-1.0_beta1 )"
#	nas? ( >=media-libs/nas-1.4.1 )

src_unpack() {
	unpack ${A}

	#if use nas; then
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
	### Ditto nas-1.6c-r1, mp3blaster-3.2.0 (2004.06.23 - eradicator)
	myconf="${myconf} --without-nas \
	        `use_with lirc` \
	        `use_with mysql` \
	        `use_with vorbis oggvorbis`"

	econf ${myconf} || die
	make CC="$(tc-getCC) ${CFLAGS}" CXX="$(tc-getCXX) ${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ANNOUNCE AUTHORS CREDITS ChangeLog FAQ NEWS README TODO
}

