# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kioslaves/kdepim-kioslaves-3.4.1.ebuild,v 1.1 2005/05/25 21:23:04 danarmak Exp $

KMNAME=kdepim
KMMODULE=kioslaves

MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdepim package"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/cyrus-sasl-2
		$(deprange $PV $MAXKDEVER kde-base/libkmime)"

KMCOPYLIB="libkmime libkmime/"
KMEXTRACTONLY="libkmime/"

