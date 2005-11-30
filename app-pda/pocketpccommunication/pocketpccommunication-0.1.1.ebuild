# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/pocketpccommunication/pocketpccommunication-0.1.1.ebuild,v 1.1.1.1 2005/11/30 10:02:26 chriswhite Exp $

inherit kde versionator autotools
MY_PV=$(replace_all_version_separators '_')
MY_P="${PN}_${MY_PV}"
S=${WORKDIR}/${PN}

DESCRIPTION="Konnector and utilities for kde pocket pc integration"
HOMEPAGE="http://synce.sourceforge.net/synce/kde/konnector"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( kde-base/kdepim-meta kde-base/kdepim )
		app-pda/synce-kde"

need-kde 3.2

src_unpack() {
	kde_src_unpack
	eautoreconf
}
