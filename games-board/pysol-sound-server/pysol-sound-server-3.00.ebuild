# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol-sound-server/pysol-sound-server-3.00.ebuild,v 1.2 2004/01/24 13:59:50 mr_bones_ Exp $

DESCRIPTION="Sound server for PySol"
HOMEPAGE="http://www.oberhumer.com/opensource/pysol/"
SRC_URI="http://www.oberhumer.com/opensource/pysol/download/${P}.tar.bz2"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.3-r1
	>=media-libs/smpeg-0.4.4-r2"

src_compile() {
	cd src || die
	./configure || die
	emake || die
}

src_install () {
	cd src || die
	emake strip || die
	python setup.py install --root=${D} || die
}

