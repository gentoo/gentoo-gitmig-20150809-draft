# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol-sound-server/pysol-sound-server-3.00.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Sound server for PySol"
SRC_URI="http://www.oberhumer.com/opensource/pysol/download/${P}.tar.bz2"
HOMEPAGE="http://www.oberhumer.com/opensource/pysol/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

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

