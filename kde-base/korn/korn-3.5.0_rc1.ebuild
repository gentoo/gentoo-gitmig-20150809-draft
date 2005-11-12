# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korn/korn-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:31 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mailbox checker"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange 3.5_beta1 $MAXKDEVER kde-base/mimelib)
$(deprange 3.5_beta1 $MAXKDEVER kde-base/libkmime)"

RDEPEND="${DEPEND}
	kde-base/kdepim-kioslaves"
KMCOPYLIB="libmimelib mimelib
	libkmime libkmime"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	mimelib/
	libkmime/
	libkdenetwork/"
