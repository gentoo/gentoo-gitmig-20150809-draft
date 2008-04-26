# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-kde/qalculate-kde-0.9.6-r1.ebuild,v 1.2 2008/04/26 12:08:20 markusle Exp $

myconf="--disable-clntest"

inherit kde autotools

DESCRIPTION="A modern multi-purpose calculator for KDE"
LICENSE="GPL-2"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=sci-libs/libqalculate-0.9.6-r1"


need-kde 3.1

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-remove-link.patch
	epatch "${FILESDIR}"/${P}-cln-config.patch
	eautoconf
}

