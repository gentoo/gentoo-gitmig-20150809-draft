# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kioslaves/kdepim-kioslaves-3.5.2-r2.ebuild,v 1.1 2006/05/01 14:00:20 carlo Exp $

KMNAME=kdepim
KMMODULE=kioslaves

MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdepim package"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="sasl"
DEPEND="sasl? ( >=dev-libs/cyrus-sasl-2 )
	$(deprange 3.5.0 $MAXKDEVER kde-base/libkmime)"

myconf="$myconf $(use_with sasl)"

KMCOPYLIB="libkmime libkmime/"
KMEXTRACTONLY="libkmime/"
KMCOMPILEONLY="libemailfunctions"

PATCHES="${FILESDIR}/kdepim-kioslaves-3.5.2-fixes-2.diff"