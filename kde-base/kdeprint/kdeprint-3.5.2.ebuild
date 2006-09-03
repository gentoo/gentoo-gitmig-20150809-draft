# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeprint/kdeprint-3.5.2.ebuild,v 1.16 2006/09/03 11:06:50 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE printer queue/device manager"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="cups kde"

# TODO Makefile reads ppd models from /usr/share/cups/model  (hardcoded !!)
DEPEND="cups? ( net-print/cups )"
RDEPEND="${DEPEND}
	app-text/enscript
	app-text/psutils
	kde? ( $(deprange-dual $PV $MAXKDEVER kde-base/kghostview) )"

src_compile() {
	myconf="$myconf `use_with cups`"
	kde-meta_src_compile
}
