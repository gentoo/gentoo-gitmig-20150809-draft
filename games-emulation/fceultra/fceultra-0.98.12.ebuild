# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fceultra/fceultra-0.98.12.ebuild,v 1.1 2004/11/24 09:14:53 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A portable NES/Famicom emulator"
HOMEPAGE="http://fceultra.sourceforge.net/"
SRC_URI="http://fceultra.sourceforge.net/releases/fceu-${PV}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="opengl"

RDEPEND="virtual/libc
	>=media-libs/libsdl-1.2.0
	opengl? ( virtual/opengl )
	sys-libs/zlib"
# Because of code generation bugs, FCEUltra now depends on a version
# of gcc greater than or equal to GCC 3.2.2.
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2.2"

S="${WORKDIR}/fceu"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--without-gtk \
		--disable-gtktest \
		$(use_with opengl) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Documentation/*.txt AUTHORS README NEWS TODO ChangeLog
	cp -r Documentation/tech "${D}/usr/share/doc/${PF}/" || die "cp failed"
	prepalldocs
	dohtml Documentation/*
	prepgamesdirs
}
