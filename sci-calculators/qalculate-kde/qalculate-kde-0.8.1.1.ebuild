# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-kde/qalculate-kde-0.8.1.1.ebuild,v 1.1 2005/08/16 00:01:03 ribosome Exp $

inherit kde

DESCRIPTION="A modern multi-purpose calculator for KDE"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

DEPEND="=sci-libs/libqalculate-0.8.1.1*
	x11-libs/qt
	kde-base/kdelibs"

DOCS="AUTHORS ChangeLog NEWS README TODO"

need-kde 3.1
