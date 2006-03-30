# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeprint/kdeprint-3.5.2.ebuild,v 1.3 2006/03/30 17:38:40 carlo Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE printer queue/device manager"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cups"

# TODO Makefile reads ppd models from /usr/share/cups/model  (hardcoded !!)
DEPEND="cups? ( net-print/cups )"
RDEPEND="${DEPEND}
	!ia64? ( app-text/enscript )
	app-text/psutils
	kde? kde-base/kghostview"

src_compile() {
	myconf="$myconf `use_with cups`"
	kde-meta_src_compile
}
