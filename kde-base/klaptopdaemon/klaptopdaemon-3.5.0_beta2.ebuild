# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.0_beta2.ebuild,v 1.3 2005/10/22 07:04:08 halcy0n Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="klaptopdaemon - KDE battery monitoring and management for laptops"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Fix output of klaptopdaemon (kde bug 103437).
PATCHES="${FILESDIR}/kdeutils-3.4.3-klaptopdaemon.patch"
