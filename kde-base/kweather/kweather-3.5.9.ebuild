# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kweather/kweather-3.5.9.ebuild,v 1.2 2008/02/24 20:20:10 ingmar Exp $

KMNAME=kdetoys
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE weather status display"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=""

PATCHES="${FILESDIR}/${P}-gcc-4.3.patch"
