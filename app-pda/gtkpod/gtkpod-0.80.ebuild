# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.80.ebuild,v 1.3 2004/07/09 21:45:52 mr_bones_ Exp $

inherit eutils

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/patch_gtk2.4-gtk2.0.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mpeg4"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/pango-1.2.1
	media-libs/libid3tag
	mpeg4? ( || ( media-libs/faad2 media-video/mpeg4ip ) )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${DISTDIR}/patch_gtk2.4-gtk2.0.diff
}

src_install() {
	einstall || die
	dodoc README
}
