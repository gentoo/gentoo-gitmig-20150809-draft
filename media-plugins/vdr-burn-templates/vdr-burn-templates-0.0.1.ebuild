# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-burn-templates/vdr-burn-templates-0.0.1.ebuild,v 1.3 2006/04/24 20:47:13 zzam Exp $

DESCRIPTION="VDR DVD Burn Plugin Templates"
HOMEPAGE="No Homepage available"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~amd64 x86"
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

	insinto /usr/share/vdr/burn
	insopts -m0644 -ovdr -gvdr
	doins ${S}/*
}
