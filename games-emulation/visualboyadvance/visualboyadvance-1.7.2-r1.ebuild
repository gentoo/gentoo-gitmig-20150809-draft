# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.2-r1.ebuild,v 1.2 2004/11/22 20:37:06 plasmaroo Exp $

inherit eutils games flag-o-matic

DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vba.ngemu.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="mmx gtk"

RDEPEND="virtual/x11
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl
	gtk? (
		>=x11-libs/gtk+-2.4
		>=dev-cpp/gtkmm-2.4
		>=dev-cpp/libglademm-2.4
	)"
DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )"

S="${WORKDIR}/VisualBoyAdvance-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-homedir.patch"
	epatch "${FILESDIR}/${PV}-gcc34.patch"
}

src_compile() {
	# -O3 causes GCC to behave badly and hog memory, bug #64670.
	replace-flags -O3 -O2

	egamesconf \
		--enable-c-core \
		$(use_with mmx) \
		$(use_enable gtk gtk 2.4) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README-win.txt
	prepgamesdirs
}
