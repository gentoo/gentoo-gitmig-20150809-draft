# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdauthor/dvdauthor-0.5.3.ebuild,v 1.2 2003/12/29 21:23:20 weeve Exp $

DESCRIPTION="Tools for generating DVD files to be played on standalone DVD players"
HOMEPAGE="http://sourceforge.net/projects/dvdauthor/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~sparc"
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
