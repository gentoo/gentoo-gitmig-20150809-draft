# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-meta/koffice-meta-1.6.3.ebuild,v 1.9 2009/06/30 21:41:15 tampakrap Exp $

MAXKOFFICEVER=${PV}
inherit kde-functions

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(deprange 1.6.2 $MAXKOFFICEVER app-office/karbon)
	$(deprange $PV $MAXKOFFICEVER app-office/kchart)
	$(deprange $PV $MAXKOFFICEVER app-office/kexi)
	$(deprange 1.6.2 $MAXKOFFICEVER app-office/kformula)
	$(deprange 1.6.2 $MAXKOFFICEVER app-office/kivio)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-data)
	$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	$(deprange 1.6.2 $MAXKOFFICEVER app-office/koshell)
	$(deprange 1.6.2 $MAXKOFFICEVER app-office/kplato)
	$(deprange $PV $MAXKOFFICEVER app-office/kpresenter)
	$(deprange $PV $MAXKOFFICEVER app-office/krita)
	$(deprange 1.6.2 $MAXKOFFICEVER app-office/kspread)
	$(deprange 1.6.2 $MAXKOFFICEVER app-office/kugar)
	$(deprange $PV $MAXKOFFICEVER app-office/kword)"
