# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.4.2.ebuild,v 1.3 2005/08/08 22:39:29 kloeri Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl xmms"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	xmms? ( media-sound/xmms )"
RDEPEND="$DEPEND
	ssl? ( app-crypt/qca-tls )"

# No meanwhile support. See bug 96778.
PATCHES="$FILESDIR/disable-meanwhile.diff"

# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
# Maybe we can enable it in the future.
#PATCHES="$PATCHES $FILESDIR/configure-fix-kdenetwork-gadu.patch"
#myconf="$myconf --with-external-libgadu"

# The nowlistening plugin has xmms support
PATCHES="$PATCHES $FILESDIR/configure-fix-kdenetwork-xmms.patch"
myconf="$myconf $(use_with xmms)"
