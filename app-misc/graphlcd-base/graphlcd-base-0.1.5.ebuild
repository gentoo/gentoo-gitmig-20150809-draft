# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/graphlcd-base/graphlcd-base-0.1.5.ebuild,v 1.6 2008/10/14 13:32:11 rbu Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="Graphical LCD Driver"
HOMEPAGE="http://graphlcd.berlios.de/"
SRC_URI="mirror://berlios/graphlcd/${P}.tgz"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="truetype g15"

DEPEND=""

RDEPEND="truetype? ( media-libs/freetype
		media-fonts/corefonts )
		g15? ( app-misc/g15daemon )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	sed -i Make.config -e "s:usr\/local:usr:" -e "s:FLAGS *=:FLAGS ?=:"
	epatch "${FILESDIR}/${P}-nostrip.patch"

	use !truetype && sed -i "s:HAVE_FREETYPE2:#HAVE_FREETYPE2:" Make.config
}

src_install() {

	make DESTDIR="${D}"/usr LIBDIR="${D}"/usr/$(get_libdir) install || die "make install failed"

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*
}
