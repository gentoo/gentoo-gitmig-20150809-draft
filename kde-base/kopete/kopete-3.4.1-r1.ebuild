# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.4.1-r1.ebuild,v 1.4 2005/07/22 17:53:02 kugelfang Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="ssl"

RDEPEND="ssl? ( app-crypt/qca-tls )"

# No meanwhile support. See bug 96778.
PATCHES="$FILESDIR/disable-meanwhile.diff"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-3.4.1-kdenetwork-libgadu.patch"

# Fix vulnerabilities in libgadu. See bug 99754.
PATCHES="$PATCHES $DISTDIR/post-3.4.1-kdenetwork-libgadu.patch"
