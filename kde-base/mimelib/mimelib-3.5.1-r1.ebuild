# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mimelib/mimelib-3.5.1-r1.ebuild,v 1.6 2006/05/30 05:09:34 josejx Exp $

KMNAME=kdepim
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mime library"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

PATCHES="${FILESDIR}/mimelib-3.5.1-memleak-fix.diff"