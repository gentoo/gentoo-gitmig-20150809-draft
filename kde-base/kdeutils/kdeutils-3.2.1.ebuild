# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.2.1.ebuild,v 1.7 2004/07/14 16:12:49 agriffis Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="x86 ~ppc sparc ~alpha hppa amd64 ~ia64"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg
	!app-crypt/kgpg"
