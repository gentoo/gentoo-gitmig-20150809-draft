# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/orpheus/orpheus-1.5.ebuild,v 1.13 2006/10/18 20:57:46 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Command line MP3 player."
HOMEPAGE="http://konst.org.ua/en/orpheus"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc sparc x86"
IUSE="ogg"

DEPEND=">=sys-libs/ncurses-5.2
	ogg? ( >=media-libs/libvorbis-1.0_beta1 )
	virtual/mpg123
	media-sound/vorbis-tools
	gnome-base/libghttp"
#	nas? ( >=media-libs/nas-1.4.1 )

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${PV}-gcc34.patch"
	epatch "${FILESDIR}/${PV}-amd64.patch"

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
	#use nas && myconf="${myconf} --with-nas"
	#use nas || myconf="${myconf} --disable-nas"
	myconf="${myconf}"

	econf ${myconf} || die "configure failed"
	make CC="$(tc-getCC) ${CFLAGS}" CXX="$(tc-getCXX) ${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
