# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.0.ebuild,v 1.8 2004/10/04 14:59:13 gmsoft Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="x86 amd64 ppc64 sparc ppc hppa"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
