# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kioslaves/kdepim-kioslaves-3.4.0_rc1.ebuild,v 1.2 2005/02/28 00:24:35 greg_g Exp $

KMNAME=kdepim
KMMODULE=kioslaves

MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdepim package"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/cyrus-sasl-2
		$(deprange $PV $MAXKDEVER kde-base/libkmime)"

KMCOPYLIB="libkmime libkmime/"
KMEXTRACTONLY="libkmime/"

# fix grave kmail bug. Probably will be fixed in 3.4 final.
PATCHES1="${FILESDIR}/kdepim-3.4.0_rc1-dimap-cache-loss.patch"
