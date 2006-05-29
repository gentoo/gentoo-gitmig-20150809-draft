# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdepim/libkdepim-3.5.2-r1.ebuild,v 1.8 2006/05/29 21:03:56 weeve Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="common library for KDE PIM apps"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 sparc x86"
IUSE=""

DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkcal)"

KMCOPYLIB="libkcal libkcal"
KMEXTRA="libemailfunctions/"

PATCHES="${FILESDIR}/libkdepim-3.5.2-call_qt3_designer.diff
	${FILESDIR}/libkdepim-3.5.2-fixes.diff"
