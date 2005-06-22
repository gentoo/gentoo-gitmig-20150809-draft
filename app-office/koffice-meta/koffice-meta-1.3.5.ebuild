# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-meta/koffice-meta-1.3.5.ebuild,v 1.5 2005/06/22 12:51:22 corsair Exp $
MAXKOFFICEVER=1.3.5

inherit kde-functions
DESCRIPTION="koffice - merge this to pull in all koffice-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

# Note most packages didn't change between koffice 1.3.4 and 1.3.5
RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/karbon)
	$(deprange $PV $MAXKOFFICEVER app-office/kchart)
	$(deprange $PV $MAXKOFFICEVER app-office/kformula)
	$(deprange $PV $MAXKOFFICEVER app-office/kivio)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-data)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	$(deprange $PV $MAXKOFFICEVER app-office/koshell)
	$(deprange $PV $MAXKOFFICEVER app-office/kpresenter)
	$(deprange $PV $MAXKOFFICEVER app-office/kspread)
	$(deprange $PV $MAXKOFFICEVER app-office/kugar)
	$(deprange $PV $MAXKOFFICEVER app-office/kword)"
