# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.1.2.ebuild,v 1.1 2003/05/07 11:05:48 danarmak Exp $

IUSE=""
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DESCRIPTION="KDE 3.1 - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND="`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils}-${PV}`"

LICENSE="GPL-2"

SLOT="3.1"
