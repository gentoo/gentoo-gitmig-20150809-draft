# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.0.ebuild,v 1.5 2006/03/28 00:08:25 agriffis Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="klaptopdaemon - KDE battery monitoring and management for laptops"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# Fix output of klaptopdaemon (kde bug 103437).
PATCHES="${FILESDIR}/kdeutils-3.4.3-klaptopdaemon.patch"
