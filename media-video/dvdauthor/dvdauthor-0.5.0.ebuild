# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdauthor/dvdauthor-0.5.0.ebuild,v 1.3 2004/01/03 15:48:07 mholzer Exp $

DESCRIPTION="Tools for generating DVD files to be played on standalone DVD players"
HOMEPAGE="http://sourceforge.net/projects/dvdauthor/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/libdvdread"

src_unpack() {
	unpack ${A}
	cd ${S}; sed -e '/CFLAGS =/d' -i.bak Makefile.in
}

src_compile() {
	econf || die "configuration failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "installation failed"
	dodoc README HISTORY TODO
}
