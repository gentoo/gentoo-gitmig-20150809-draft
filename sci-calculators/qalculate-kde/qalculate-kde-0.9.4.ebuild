# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-kde/qalculate-kde-0.9.4.ebuild,v 1.3 2007/07/15 06:05:01 mr_bones_ Exp $

myconf="--disable-clntest"

inherit kde

DESCRIPTION="A modern multi-purpose calculator for KDE"
LICENSE="GPL-2"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~sparc x86"

DEPEND="=sci-libs/libqalculate-0.9.4*
	kde-base/kdelibs"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}/${PN}-makefile.patch"
}

need-kde 3.1
