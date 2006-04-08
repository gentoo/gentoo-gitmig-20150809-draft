# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-meta/koffice-meta-1.5_rc1.ebuild,v 1.2 2006/04/08 19:54:52 nixnut Exp $

MAXKOFFICEVER=${PV}
inherit kde-functions

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/karbon)
	$(deprange $PV $MAXKOFFICEVER app-office/kchart)
	$(deprange $PV $MAXKOFFICEVER app-office/kexi)
	$(deprange $PV $MAXKOFFICEVER app-office/kformula)
	$(deprange $PV $MAXKOFFICEVER app-office/kivio)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-data)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	$(deprange $PV $MAXKOFFICEVER app-office/koshell)
	$(deprange $PV $MAXKOFFICEVER app-office/kplato)
	$(deprange $PV $MAXKOFFICEVER app-office/kpresenter)
	$(deprange $PV $MAXKOFFICEVER app-office/krita)
	$(deprange $PV $MAXKOFFICEVER app-office/kspread)
	$(deprange $PV $MAXKOFFICEVER app-office/kugar)
	$(deprange $PV $MAXKOFFICEVER app-office/kword)"
