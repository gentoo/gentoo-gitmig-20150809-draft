# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.80.2.ebuild,v 1.1 2004/07/18 16:47:20 tester Exp $

inherit eutils

#Sorry I'm just too lazy to do bash magic to fix it
PV2=0.80-2

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mpeg4"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/pango-1.2.1
	media-libs/libid3tag
	mpeg4? ( || ( media-libs/faad2 media-video/mpeg4ip ) )"

S=${WORKDIR}/${PN}-${PV2}

src_install() {
	einstall || die
	dodoc README
}
