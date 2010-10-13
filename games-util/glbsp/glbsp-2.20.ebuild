# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/glbsp/glbsp-2.20.ebuild,v 1.6 2010/10/13 23:47:59 mr_bones_ Exp $

EAPI=2
inherit eutils toolchain-funcs versionator

MY_PV=$(delete_version_separator 1)
DESCRIPTION="A node builder specially designed for OpenGL ports of the DOOM game engine"
HOMEPAGE="http://glbsp.sourceforge.net/"
SRC_URI="mirror://sourceforge/glbsp/${PN}_src_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="fltk"

DEPEND="fltk? ( x11-libs/fltk:1.1 )"

src_prepare() {
	sed -i \
		-e "/^CC=/s:=.*:=$(tc-getCC):" \
		-e "/^CXX=/s:=.*:=$(tc-getCXX):" \
		-e "/^AR=/s:ar:$(tc-getAR):" \
		-e "/^RANLIB=/s:=.*:=$(tc-getRANLIB):" \
		-e "s:-O2:${CFLAGS}:" \
		GUI_unx.mak Plugin_unx.mak Makefile \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	emake || die "emake failed"
	emake -f Plugin_unx.mak || die "emake failed"

	if use fltk ; then
		emake -f GUI_unx.mak \
			FLTK_CFLAGS="$(fltk-config --cflags)" \
			FLTK_LIBS="$(fltk-config --use-images --ldflags)" \
			|| die "emake failed"
	fi
}

src_install() {
	dobin glbsp || die "dobin failed"
	dolib.a libglbsp.a || die "dolib.a failed"

	if use fltk ; then
		newbin glBSPX glbspx || die "newbin failed"
		newicon fltk/icon.xpm glbspx.xpm
		make_desktop_entry glbspx glBSPX glbspx
	fi

	doman glbsp.1
	dodoc CHANGES.txt README.txt TODO.txt USAGE.txt
}
