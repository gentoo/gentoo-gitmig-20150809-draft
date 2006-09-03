# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kioslaves/kdepim-kioslaves-3.5.2-r3.ebuild,v 1.9 2006/09/03 15:30:54 kloeri Exp $

KMNAME=kdepim
KMMODULE=kioslaves

MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdepim package"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="sasl"
DEPEND="sasl? ( >=dev-libs/cyrus-sasl-2 )
	$(deprange 3.5.0 $MAXKDEVER kde-base/libkmime)"

KMCOPYLIB="libkmime libkmime/"
KMEXTRACTONLY="libkmime/"
KMCOMPILEONLY="libemailfunctions"

PATCHES="${FILESDIR}/kdepim-kioslaves-3.5.2-fixes-2.diff ${FILESDIR}/imap-dos.diff"

src_compile() {
	myconf="$myconf $(use_with sasl)"
	kde-meta_src_compile
}
