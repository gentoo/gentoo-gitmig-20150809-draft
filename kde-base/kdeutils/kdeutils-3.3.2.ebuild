# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.2.ebuild,v 1.9 2005/01/25 00:12:01 vapier Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
