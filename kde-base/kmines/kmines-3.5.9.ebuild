# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmines/kmines-3.5.9.ebuild,v 1.6 2008/05/14 19:28:06 corsair Exp $
KMNAME=kdegames
EAPI="1"
inherit kde-meta

DESCRIPTION="KMines is a classic mine sweeper game"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=">=kde-base/libkdegames-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"

RESTRICT="test"
