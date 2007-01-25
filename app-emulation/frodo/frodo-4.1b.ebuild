# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/frodo/frodo-4.1b.ebuild,v 1.2 2007/01/25 22:04:26 genone Exp $

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="latest"
inherit eutils flag-o-matic autotools

DESCRIPTION="An excellent Commodore 64 Emulator"
HOMEPAGE="http://frodo.cebix.net/"
SRC_URI="http://frodo.cebix.net/downloads/FrodoV4_1b.Src.tar.gz"

LICENSE="Frodo"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""
S="${WORKDIR}/Frodo-4.1b"

RDEPEND=">=media-libs/libsdl-1.2
	dev-lang/tcl
	dev-lang/tk"

src_compile() {
	cd ${S}
	append-flags "-DX_USE_SHM"
	mv TkGui.tcl ${S}/Src
	cd ${S}/Src
	epatch ${FILESDIR}/${P}-gentoo.diff
	rm configure
	autoconf
	econf || die
	emake || die "emake failed"
}

src_install() {
	cd ${S}/Src
	dobin Frodo FrodoPC FrodoSC TkGui.tcl
	cd ${S}
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins \
		"1541 ROM" \
		"Basic ROM" \
		"Char ROM" \
		"Kernal ROM"
	dodir /usr/share/${PN}/64prgs
	cd ${S}/64prgs
	insinto /usr/share/${PN}/64prgs
	doins \
		3fff \
		colorbars \
		d011h3 \
		dadb \
		de00all \
		dycp \
		fld \
		lrborder \
		sprsync \
		stretch \
		tech-tech \
		text26
	dohtml -r ${S}/Docs/*.html
}

pkg_postinst() {
	elog
	elog " READ THE DOCS!  The documentation can be found at:"
	elog "   /usr/share/doc/${PF}/html/"
	elog
	elog " Getting this program to work requires some experimentation with the"
	elog " settings.  The three executables you can use are:"
	elog
	elog "   Frodo   (normal)"
	elog "   FrodoPC (faster)"
	elog "   FrodoSC (slower than the other two, but most compatible)"
	elog
	elog " We recommend that you run FrodoSC with the following settings:"
	elog
	elog "   1.  Limit Speed = enabled"
	elog "   2.  Map / = enabled"
	elog "   3.  Emulate 1541 CPU (for copy-protected games)"
	elog "   4.  Sprites, Sprite Collisions = enabled"
	elog "   5.  SID Emulation = Digital"
	elog "   6.  SID Filters = enabled"
	elog
	elog " You will probably need to occasionally change these settings"
	elog " depending upon which programs you try to run, or you may need to run"
	elog " Frodo or FrodoPC if your machine is too slow."
	elog
	elog " Most Commodore 64 applications load by first pointing to the D64"
	elog " file in preferences, then:"
	elog "      LOAD \"*\",8,1"
	elog " then:"
	elog "      RUN"
	elog
	elog " Remember that the keyboard is mapped to the C64 layout.  So to type"
	elog " the first command above you would use the following sequence:"
	elog "     LOAD [SHIFT-2][RIGHT-BRACKET][SHIFT-2],8,1"
	elog
	elog
	elog " For a complete source of C64 programs, try visiting:"
	elog "   http://www.c64unlimited.net/"
	elog
}
