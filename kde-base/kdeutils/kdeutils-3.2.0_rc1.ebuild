# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.2.0_rc1.ebuild,v 1.1 2004/01/19 03:18:41 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE utilities"

KEYWORDS="~x86 ~sparc ~amd64"

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg
	!app-crypt/kgpg"
RDEPEND="$DEPEND"
