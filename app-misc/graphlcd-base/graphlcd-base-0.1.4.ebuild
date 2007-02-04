# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/graphlcd-base/graphlcd-base-0.1.4.ebuild,v 1.1 2007/02/04 23:30:38 hd_brummy Exp $

inherit eutils flag-o-matic

DESCRIPTION="Graphical LCD Driver"
HOMEPAGE="http://graphlcd.berlios.de/"
SRC_URI="http://download.berlios.de/graphlcd/${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="truetype g15"

DEPEND=""

RDEPEND="truetype? ( media-libs/freetype
		media-fonts/corefonts )
		g15? ( app-misc/g15daemon )"

src_unpack() {

	unpack ${A}
	cd ${S}

	sed -i Make.config -e "s:usr\/local:usr:" -e "s:FLAGS *=:FLAGS ?=:"
	epatch ${FILESDIR}/${PN}-0.1.3-nostrip.patch

	use !truetype && sed -i "s:HAVE_FREETYPE2:#HAVE_FREETYPE2:" Make.config
}

src_install() {

	make DESTDIR=${D}/usr install || die "make install failed"

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*
}
