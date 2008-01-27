# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksudoku/ksudoku-4.0.0.ebuild,v 1.2 2008/01/27 20:47:09 zlin Exp $

EAPI="1"

KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="KDE Sudoku"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="virtual/opengl"
RDEPEND="${DEPEND}"

QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} opengl"
