# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-kde/qalculate-kde-0.8.0.ebuild,v 1.1 2005/06/05 15:25:13 ribosome Exp $

inherit kde

DESCRIPTION="A modern multi-purpose calculator for KDE"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sci-libs/libqalculate
	x11-libs/qt
	kde-base/kdelibs"

DOCS="AUTHORS ChangeLog NEWS README TODO"

need-kde 3.1
