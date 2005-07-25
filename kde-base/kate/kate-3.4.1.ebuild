# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate/kate-3.4.1.ebuild,v 1.8 2005/07/25 19:04:05 caleb Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE MDI editor/ide"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

KMEXTRA="doc/kwrite"
PATCHES="${FILESDIR}/kate-gcc-4.patch"

