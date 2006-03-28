# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korn/korn-3.5.0.ebuild,v 1.7 2006/03/28 00:32:25 agriffis Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mailbox checker"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/mimelib)
$(deprange $PV $MAXKDEVER kde-base/libkmime)"

RDEPEND="${DEPEND}
	kde-base/kdebase-kioslaves
	kde-base/kdepim-kioslaves"
KMCOPYLIB="libmimelib mimelib
	libkmime libkmime"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	mimelib/
	libkmime/
	libkdenetwork/"
