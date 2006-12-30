# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/frodo/frodo-4.1b.ebuild,v 1.1 2006/12/30 07:03:42 antarus Exp $

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
	einfo
	einfo " READ THE DOCS!  The documentation can be found at:"
	einfo "   /usr/share/doc/${PF}/html/"
	einfo
	einfo " Getting this program to work requires some experimentation with the"
	einfo " settings.  The three executables you can use are:"
	einfo
	einfo "   Frodo   (normal)"
	einfo "   FrodoPC (faster)"
	einfo "   FrodoSC (slower than the other two, but most compatible)"
	einfo
	einfo " We recommend that you run FrodoSC with the following settings:"
	einfo
	einfo "   1.  Limit Speed = enabled"
	einfo "   2.  Map / = enabled"
	einfo "   3.  Emulate 1541 CPU (for copy-protected games)"
	einfo "   4.  Sprites, Sprite Collisions = enabled"
	einfo "   5.  SID Emulation = Digital"
	einfo "   6.  SID Filters = enabled"
	einfo
	einfo " You will probably need to occasionally change these settings"
	einfo " depending upon which programs you try to run, or you may need to run"
	einfo " Frodo or FrodoPC if your machine is too slow."
	einfo
	einfo " Most Commodore 64 applications load by first pointing to the D64"
	einfo " file in preferences, then:"
	einfo "      LOAD \"*\",8,1"
	einfo " then:"
	einfo "      RUN"
	einfo
	einfo " Remember that the keyboard is mapped to the C64 layout.  So to type"
	einfo " the first command above you would use the following sequence:"
	einfo "     LOAD [SHIFT-2][RIGHT-BRACKET][SHIFT-2],8,1"
	einfo
	einfo
	einfo " For a complete source of C64 programs, try visiting:"
	einfo "   http://www.c64unlimited.net/"
	einfo
}
