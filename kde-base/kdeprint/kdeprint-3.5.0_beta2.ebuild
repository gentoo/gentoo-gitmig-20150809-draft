# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeprint/kdeprint-3.5.0_beta2.ebuild,v 1.2 2005/10/22 06:51:02 halcy0n Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE printer queue/device manager"
KEYWORDS="~amd64 ~x86"
IUSE="cups"

DEPEND="cups? ( net-print/cups )"

src_compile() {
	myconf="$myconf `use_with cups`"
	kde-meta_src_compile
}
