# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.0_alpha1.ebuild,v 1.3 2004/06/24 22:14:14 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~x86 ~amd64"

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"

