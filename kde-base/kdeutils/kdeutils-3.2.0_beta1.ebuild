# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.2.0_beta1.ebuild,v 1.3 2003/11/05 18:44:35 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE utilities"

KEYWORDS="~x86"

newdepend "=kde-base/kdebase-${PV}
	!app-crypt/kgpg"
