# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-riceplugin/mupen64-riceplugin-5.1.0.ebuild,v 1.2 2005/01/06 05:10:53 morfic Exp $

inherit games gcc eutils libtool

IUSE=""

DESCRIPTION="an graphics plugin for mupen64"
SRC_URI="http://mupen64.emulation64.com/files/0.4/riceplugin.tar.bz2"
HOMEPAGE="http://mupen64.emulation64.com/"

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="sys-libs/zlib
	!gtk2? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )
	media-libs/libsdl
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/riceplugin"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-makefile.patch
	epatch ${FILESDIR}/${PN}-gcc3.patch

	# the riceplugin requires sse support
	#echo "#include <xmmintrin.h>" > ${T}/test.c
	#$(gcc-getCC) ${CFLAGS} -o ${T}/test.s -S ${T}/test.c >&/dev/null || die
	#"failed sse test"

}

src_compile() {

	emake || die "emake failed"

}

src_install() {
	local dir=${GAMES_LIBDIR}/mupen64
	dodir ${dir}

	exeinto ${dir}/plugins
	doexe *.so
	insinto ${dir}/plugins
	doins *.ini

	prepgamesdirs
}
