# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/networkstatus/networkstatus-3.4.2.ebuild,v 1.10 2006/03/26 19:57:12 agriffis Exp $

KMNAME=kdepim
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE network connection status tracking daemon"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
