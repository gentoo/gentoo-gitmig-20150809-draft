# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.0.ebuild,v 1.1 2004/08/19 15:15:48 caleb Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
