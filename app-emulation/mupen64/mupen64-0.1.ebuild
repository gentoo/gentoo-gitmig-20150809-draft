# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mupen64/mupen64-0.1.ebuild,v 1.3 2003/06/26 00:30:54 vapier Exp $

inherit games

DESCRIPTION="A Nintendo 64 (N64) emulator"
#SRC_URI="http://mupen64.emulation64.com/files/mupen64_${PV}.tgz"
SRC_URI="mirror://gentoo/mupen64_${PV}_src.tgz"
HOMEPAGE="http://mupen64.emulation64.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc"

DEPEND="=x11-libs/gtk+-1.2*
	>=sys-apps/sed-4
	media-libs/libsdl
	virtual/glu
	virtual/opengl"

S=${WORKDIR}/emu64

src_unpack() {
	unpack ${A}
	sed -i -e "/^CC.*/s:$: ${CFLAGS}:" ${S}/Makefile || die "sed failed"
}

src_compile() {
	emake || die
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}
	dodir ${dir}

	cp -r mupen64* lang plugins save roms path.cfg ${D}/${dir}/
	sed -e "s:GENTOO_DIR:${dir}:" \
		${FILESDIR}/mupen64 > ${T}/mupen64
	dogamesbin ${T}/mupen64

	dodoc *.txt
	dohtml index.htm

	prepgamesdirs
}
