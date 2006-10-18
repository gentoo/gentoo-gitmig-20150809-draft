# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.2-r1.ebuild,v 1.10 2006/10/18 23:19:44 nyhm Exp $

inherit eutils flag-o-matic games

DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vba.ngemu.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="mmx gtk"

RDEPEND="media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl
	gtk? (
		>=x11-libs/gtk+-2.4
		>=dev-cpp/gtkmm-2.4
		>=dev-cpp/libglademm-2.4
	)"
DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )"

S=${WORKDIR}/VisualBoyAdvance-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-homedir.patch"
	epatch "${FILESDIR}/${PV}-gcc34.patch"
	epatch "${FILESDIR}/${PV}-gcc41.patch"
}

src_compile() {
	# -O3 causes GCC to behave badly and hog memory, bug #64670.
	replace-flags -O3 -O2

	# Removed --enable-c-core as it *should* determine this based on arch
	egamesconf \
		$(use_with mmx) \
		$(use_enable gtk gtk 2.4) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README README-win.txt
	prepgamesdirs
}
