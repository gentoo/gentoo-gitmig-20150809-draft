# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.0.ebuild,v 1.5 2004/09/09 16:24:33 caleb Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="x86 ~amd64 ppc64 ~sparc ppc"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
