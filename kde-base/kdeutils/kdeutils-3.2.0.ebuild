# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.2.0.ebuild,v 1.13 2005/02/08 14:53:40 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
