# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.4.0-r1.ebuild,v 1.1 2005/04/03 23:46:26 greg_g Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="ssl"

RDEPEND="ssl? ( app-crypt/qca-tls )"

# fix kde bug 91288. Applied for 3.4.1.
PATCHES1="${FILESDIR}/kdenetwork-3.4.0-kopete-logout.patch"

# fix kde bug 99671. Applied for 3.4.1.
PATCHES1="${PATCHES1} ${FILESDIR}/kdenetwork-3.4.0-kopete-spaces.patch"
