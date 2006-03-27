# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korn/korn-3.4.3.ebuild,v 1.9 2006/03/27 14:44:50 agriffis Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mailbox checker"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange 3.4.2 $MAXKDEVER kde-base/mimelib)
$(deprange 3.4.1 $MAXKDEVER kde-base/libkmime)"
OLDDEPEND="~kde-base/mimelib-$PV ~kde-base/libkmime-$PV"
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
