# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fceultra/fceultra-0.98.10.ebuild,v 1.1 2004/05/29 22:25:59 dholm Exp $

inherit games gcc eutils

DESCRIPTION="A portable NES/Famicom emulator"
HOMEPAGE="http://fceultra.sourceforge.net/"
SRC_URI="http://fceultra.sourceforge.net/releases/fceu-${PV}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="sdl gtk opengl"

# Because of code generation bugs, FCEUltra now depends on a version
# of gcc greater than or equal to GCC 3.2.2.
RDEPEND="|| (
		gtk? ( >=x11-libs/gtk+-2.2.0 )
		sdl? ( >=media-libs/libsdl-1.2.0 )
		opengl? ( virtual/opengl )
	)
	>=sys-devel/gcc-3.2.2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/fceu

src_compile() {
	local myconf
	use sdl && myconf="${myconf} --with-sdl"
	use gtk && myconf="${myconf} --with-gtk"
	use opengl && myconf="${myconf} --with-opengl"
	egamesconf ${myconf} || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die "install failed"
	dodoc Documentation/*.txt AUTHORS README NEWS COPYING TODO ChangeLog
	cp -r Documentation/tech "${D}/usr/share/doc/${P}/" || die "cp failed"
	find ${D}/usr/share/doc/${P}/tech -type f -exec gzip -9 \{\} \; || \
		die "find failed"
	dohtml Documentation/* || die "dohtml failed"
	prepgamesdirs
}
