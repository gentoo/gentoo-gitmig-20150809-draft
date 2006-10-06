# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/magickthumbnail/magickthumbnail-0.5.1.ebuild,v 1.1 2006/10/06 13:33:33 lack Exp $

ROX_LIB="2.0.0"
inherit rox eutils

MY_PN="MagickThumbnail"

DESCRIPTION="MagickThumbnail can generate thumbnails of many files many types in your ROX-Filer window."
HOMEPAGE="http://kulinarna.maczewski.dyndns.org/rox/"
SRC_URI="http://kulinarna.maczewski.dyndns.org/rox/prog/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

APPNAME=${MY_PN}
S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-config_location.patch
}
