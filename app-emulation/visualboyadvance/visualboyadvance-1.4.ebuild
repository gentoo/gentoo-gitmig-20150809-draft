# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/visualboyadvance/visualboyadvance-1.4.ebuild,v 1.1 2003/03/02 07:40:19 vapier Exp $

inherit games

MY_PN="VisualBoyAdvance"
DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vboy.emuhq.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-${PV}-src.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="x86"
IUSE="mmx"

DEPEND="mmx? ( dev-lang/nasm )
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl
	virtual/x11"

S=${WORKDIR}/${MY_PN}-${PV}

src_compile() {
	for m in `find -name Makefile.in` ; do
		cp ${m}{,.orig}
		sed -e "s:@LIBTOOL@:/usr/bin/libtool:" ${m}.orig > ${m}
	done

	egamesconf \
		--enable-c-core \
		`use_with mmx` \
		|| die

	emake || die
}

src_install() {
	egamesinstall || die
	dodoc README README-win.txt INSTALL ChangeLog AUTHORS NEWS
	insinto ${GAMES_DATADIR}/VisualBoyAdvance
	doins src/VisualBoyAdvance.cfg
	dogamesbin ${FILESDIR}/playvisualboyadvance
	prepgamesdirs
}
