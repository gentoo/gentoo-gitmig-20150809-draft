# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.0_beta1.ebuild,v 1.2 2004/07/14 16:12:49 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
