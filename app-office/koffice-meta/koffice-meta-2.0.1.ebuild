# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-meta/koffice-meta-2.0.1.ebuild,v 1.1 2009/06/25 12:32:01 scarabeus Exp $

EAPI=2

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	>=app-office/karbon-${PV}:${SLOT}
	>=app-office/kchart-${PV}:${SLOT}
	>=app-office/koffice-data-${PV}:${SLOT}
	>=app-office/koffice-libs-${PV}:${SLOT}
	>=app-office/kplato-${PV}:${SLOT}
	>=app-office/kpresenter-${PV}:${SLOT}
	>=app-office/krita-${PV}:${SLOT}
	>=app-office/kspread-${PV}:${SLOT}
	>=app-office/kword-${PV}:${SLOT}
	nls? ( >=app-office/koffice-l10n-${PV}:${SLOT} )
"
