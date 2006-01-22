# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.1.ebuild,v 1.1 2006/01/22 22:53:01 danarmak Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="klaptopdaemon - KDE battery monitoring and management for laptops"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# Fix output of klaptopdaemon (kde bug 103437).
PATCHES="${FILESDIR}/kdeutils-3.4.3-klaptopdaemon.patch"
