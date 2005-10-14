# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kioslaves/kdepim-kioslaves-3.5.0_beta2.ebuild,v 1.1 2005/10/14 18:41:52 danarmak Exp $

KMNAME=kdepim
KMMODULE=kioslaves

MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdepim package"
KEYWORDS="~amd64"
IUSE="sasl"
DEPEND="sasl? ( >=dev-libs/cyrus-sasl-2 )
	$(deprange 3.5_beta1 $MAXKDEVER kde-base/libkmime)"

myconf="$myconf $(use_with sasl)"

KMCOPYLIB="libkmime libkmime/"
KMEXTRACTONLY="libkmime/"
KMCOMPILEONLY="libemailfunctions"

