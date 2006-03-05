# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-burn-templates/vdr-burn-templates-0.0.1.ebuild,v 1.1 2006/03/05 21:12:21 hd_brummy Exp $

DESCRIPTION="VDR DVD Burn Plugin Templates"
HOMEPAGE="No Homepage available"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND=">=media-plugins/vdr-burn-0.0.9-r2"

S="${WORKDIR}/templates"

src_unpack() {

	unpack ${A}
	cd ${S}
}

src_install() {

	insinto /usr/share/vdr/burn/templates
	insopts -m0644 -ovdr -gvdr
	doins ${S}/*
}
