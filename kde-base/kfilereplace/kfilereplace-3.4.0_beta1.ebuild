# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfilereplace/kfilereplace-3.4.0_beta1.ebuild,v 1.3 2005/02/08 15:14:19 greg_g Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE batch search&replace tool"
KEYWORDS="~x86"
IUSE=""

src_install() {
	kde-meta_src_install

	# Collision with kdelibs. Will be fixed for beta2.
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/22x22/actions/next.png
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/22x22/actions/back.png
}
