# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pachi/pachi-1.0.ebuild,v 1.1 2004/04/05 06:31:23 mr_bones_ Exp $

inherit games

DESCRIPTION="platform game inspired by games like Manic Miner and Jet Set Willy"
HOMEPAGE="http://dragontech.sourceforge.net/index.php?main=pachi&lang=en"
# Upstream doesn't version their releases.
# (should be downloaded and re-compressed with tar -jcvf)
#SRC_URI="mirror://sourceforge/dragontech/pachi_source.tgz"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	media-libs/sdl-mixer
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-devel/automake"

S="${WORKDIR}/Pachi"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-autotools.patch"
	aclocal
	automake -a
	autoconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}/usr/share/games/doc"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
