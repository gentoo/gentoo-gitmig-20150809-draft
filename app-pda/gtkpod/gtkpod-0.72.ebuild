# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.72.ebuild,v 1.5 2004/04/07 19:03:15 vapier Exp $

inherit eutils

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/mp4file.c"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mpeg4"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/pango-1.2.1
	media-libs/libid3tag
	mpeg4? ( || ( media-libs/faad2 media-video/mpeg4ip ) )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gtkpod-0.72-c89_fix.patch
	cd ${S}
	cp ${DISTDIR}/mp4file.c ${S}/src
	epatch ${FILESDIR}/gtkpod-0.72-faad2.patch
}

src_install() {
	einstall || die
	dodoc README
}
