# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.1_rc5.ebuild,v 1.3 2002/12/26 00:41:46 bjb Exp $

KEYWORDS="x86 sparc alpha"
DESCRIPTION="KDE 3.1 RC 5 - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND="`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils}-${PV}`"

LICENSE="GPL-2"

SLOT="3.1"
