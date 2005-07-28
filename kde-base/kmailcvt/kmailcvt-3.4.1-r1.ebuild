# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmailcvt/kmailcvt-3.4.1-r1.ebuild,v 1.1 2005/07/28 11:31:30 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KMail Import Filters"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

PATCHES="$FILESDIR/fix-kmailcvt-compilation.diff" # remove for 3.4.3
