# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.2.0_beta2.ebuild,v 1.2 2004/01/04 15:26:06 weeve Exp $

IUSE=""
KEYWORDS="~x86 ~sparc"
DESCRIPTION="KDE 3.2 - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND="`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils,accessibility}-${PV}`"

LICENSE="GPL-2"

SLOT="3.2"
