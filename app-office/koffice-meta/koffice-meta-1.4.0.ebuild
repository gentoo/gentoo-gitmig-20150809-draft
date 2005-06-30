# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-meta/koffice-meta-1.4.0.ebuild,v 1.4 2005/06/30 12:55:42 josejx Exp $

MAXKOFFICEVER=${PV}
inherit kde-functions

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/karbon)
	$(deprange $PV $MAXKOFFICEVER app-office/kchart)
	$(deprange $PV $MAXKOFFICEVER app-office/kexi)
	$(deprange $PV $MAXKOFFICEVER app-office/kformula)
	$(deprange $PV $MAXKOFFICEVER app-office/kivio)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-data)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	$(deprange $PV $MAXKOFFICEVER app-office/koshell)
	$(deprange $PV $MAXKOFFICEVER app-office/kpresenter)
	$(deprange $PV $MAXKOFFICEVER app-office/krita)
	$(deprange $PV $MAXKOFFICEVER app-office/kspread)
	$(deprange $PV $MAXKOFFICEVER app-office/kugar)
	$(deprange $PV $MAXKOFFICEVER app-office/kword)"
