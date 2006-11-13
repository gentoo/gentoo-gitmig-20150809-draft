# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/waif/waif-0.59.7.ebuild,v 1.16 2006/11/13 15:21:07 flameeyes Exp $

inherit eutils

S=${WORKDIR}/${PN}

DESCRIPTION="Why Another Infernal Frontend -- console front end for various media-players"
HOMEPAGE="http://eds.org/~straycat/waif.html"
SRC_URI="http://www.eds.org/~straycat/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc x86 sparc amd64"
IUSE="ogg"

DEPEND="dev-lang/tcl
	dev-tcltk/expect"
RDEPEND="dev-tcltk/expect
	virtual/mpg123
	media-sound/takcd
	media-sound/aumix
	media-libs/id3lib
	media-sound/id3v2
	media-sound/id3ed
	ogg? ( media-sound/vorbis-tools )"

src_compile() {
	cd Waif
	./mkindex.sh || die
}

src_install() {
	local tclv
	tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's:^.*"\(.*\)".*:\1:')

	cd ${S}
	insinto /usr/$(get_libdir)/tcl${tclv}/Waif
	doins Waif/*

	into /usr
	dobin waif-helper waifsh
	doman waifsh.1

	dodoc CHANGES FAQ INSTALL README* TODO WHATSNEW
	docinto Documentation
	dodoc Documentation/*
}
