# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.1.ebuild,v 1.1 2004/10/13 13:56:31 caleb Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~x86 ~amd64 ~ppc64 ~sparc ~ppc ~hppa"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
