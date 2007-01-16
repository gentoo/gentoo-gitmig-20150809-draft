# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdepim/libkdepim-3.5.6.ebuild,v 1.1 2007/01/16 21:50:43 flameeyes Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="common library for KDE PIM apps"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkcal libkcal"
KMEXTRA="libemailfunctions/
	pixmaps"

src_unpack() {
	kde-meta_src_unpack
	# Call Qt 3 designer
	sed -i -e "s:\"designer\":\"${QTDIR}/bin/designer\":g" ${S}/libkdepim/kcmdesignerfields.cpp || die "sed failed"
}
