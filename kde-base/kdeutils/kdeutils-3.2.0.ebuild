# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.2.0.ebuild,v 1.7 2004/02/19 14:46:32 vapier Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="x86 ppc sparc hppa ~amd64"

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg
	!app-crypt/kgpg"
