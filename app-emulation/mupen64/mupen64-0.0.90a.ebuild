# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mupen64/mupen64-0.0.90a.ebuild,v 1.3 2003/03/03 12:44:43 vladimir Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A Nintendo 64 (N64) emulator"
SRC_URI="http://mupen64.emulation64.com/mupen64_linux_0_0_90a.tgz"
HOMEPAGE="http://mupen64.emulation64.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc" 

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/libsdl
	virtual/glu
	virtual/opengl"
	
src_install () {
	dodir /opt/${PN} /opt/${PN}/plugins

	exeinto /opt/${PN}/
	doexe mupen64
	dobin ${FILESDIR}/mupen64

	insinto /usr/lib/${PN}/plugins
	doins plugins/*

	dodoc *.txt README.OBSIDIAN
	dohtml index.html
}

pkg_postinst() {
	einfo "Please note that mupen64 currectly only works in pure interpreter mode."
	einfo "For best results, use the TR64 gfx plugin and emerge the blight_input plugin."
}
	
