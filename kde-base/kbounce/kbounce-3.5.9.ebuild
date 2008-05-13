# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbounce/kbounce-3.5.9.ebuild,v 1.5 2008/05/13 03:21:39 jer Exp $

KMNAME=kdegames
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE Bounce Ball Game"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=">=kde-base/libkdegames-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
