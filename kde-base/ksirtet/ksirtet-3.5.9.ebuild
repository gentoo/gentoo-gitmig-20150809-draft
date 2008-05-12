# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksirtet/ksirtet-3.5.9.ebuild,v 1.5 2008/05/12 20:03:00 ranger Exp $
KMNAME=kdegames
EAPI="1"
inherit kde-meta

DESCRIPTION="KSirtet is an adaptation of the well-known Tetris game"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=">=kde-base/libkdegames-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdegames
KMCOMPILEONLY=libksirtet
KMCOPYLIB="libkdegames libkdegames"

PATCHES="${FILESDIR}/${P}-gcc-4.3.patch"
