# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pachi/pachi-1.0.ebuild,v 1.7 2006/09/20 16:46:54 blubb Exp $

inherit eutils games

DESCRIPTION="platform game inspired by games like Manic Miner and Jet Set Willy"
HOMEPAGE="http://dragontech.sourceforge.net/index.php?main=pachi&lang=en"
# Upstream doesn't version their releases.
# (should be downloaded and re-compressed with tar -jcvf)
#SRC_URI="mirror://sourceforge/dragontech/pachi_source.tgz"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	media-libs/sdl-mixer
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-devel/automake"

S=${WORKDIR}/Pachi

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-autotools.patch"
	export WANT_AUTOCONF=2.5
	aclocal && automake -a && autoconf || die "autotools failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}/usr/share/games/doc"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
