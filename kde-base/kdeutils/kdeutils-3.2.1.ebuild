# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.2.1.ebuild,v 1.3 2004/03/12 21:10:01 caleb Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64 ~ia64"

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg
	!app-crypt/kgpg"
