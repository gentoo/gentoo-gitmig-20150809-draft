# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.4.1-r1.ebuild,v 1.7 2006/02/21 14:15:39 flameeyes Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"

KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="ssl"

RDEPEND="ssl? ( app-crypt/qca-tls )
	!net-im/kopete"

# No meanwhile support. See bug 96778.
PATCHES="$FILESDIR/disable-meanwhile.diff"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-3.4.1-kdenetwork-libgadu.patch"

# Fix vulnerabilities in libgadu. See bug 99754.
PATCHES="$PATCHES $DISTDIR/post-3.4.1-kdenetwork-libgadu.patch"
