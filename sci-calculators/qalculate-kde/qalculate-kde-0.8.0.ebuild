# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-kde/qalculate-kde-0.8.0.ebuild,v 1.3 2005/07/23 21:53:52 ribosome Exp $

inherit kde

DESCRIPTION="A modern multi-purpose calculator for KDE"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc x86"
IUSE=""

DEPEND="sci-libs/libqalculate
	x11-libs/qt
	kde-base/kdelibs"

DOCS="AUTHORS ChangeLog NEWS README TODO"

need-kde 3.1
