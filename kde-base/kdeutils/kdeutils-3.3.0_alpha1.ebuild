# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.3.0_alpha1.ebuild,v 1.1 2004/05/26 22:34:20 caleb Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~x86"

DEPEND="~kde-base/kdebase-${PV}
	app-crypt/gnupg"

