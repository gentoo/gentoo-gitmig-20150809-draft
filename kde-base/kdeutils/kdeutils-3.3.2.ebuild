# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.2.ebuild,v 1.11 2005/07/02 02:49:56 hardave Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"
