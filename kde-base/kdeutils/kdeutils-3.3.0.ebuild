# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.0.ebuild,v 1.2 2004/08/23 04:09:12 tgall Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~x86 ~amd64 ppc64"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
