# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys/kdetoys-3.5.9.ebuild,v 1.9 2008/07/09 09:38:20 loki_val Exp $

EAPI="1"
inherit kde-dist

DESCRIPTION="KDE toys"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="kdehiddenvisibility"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )
