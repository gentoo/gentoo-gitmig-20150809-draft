# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kblackbox/kblackbox-3.5.9.ebuild,v 1.4 2008/05/12 20:01:47 ranger Exp $
KMNAME=kdegames
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE Blackbox Game"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=">=kde-base/libkdegames-${PV}:${SLOT}"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
