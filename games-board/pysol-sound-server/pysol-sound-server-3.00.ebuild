# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol-sound-server/pysol-sound-server-3.00.ebuild,v 1.7 2005/01/01 22:16:01 vapier Exp $

DESCRIPTION="Sound server for PySol"
HOMEPAGE="http://www.oberhumer.com/opensource/pysol/"
SRC_URI="http://www.oberhumer.com/opensource/pysol/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.3-r1
	>=media-libs/smpeg-0.4.4-r2"

src_compile() {
	cd src
	./configure || die "configure failed"
	emake || die "make failed"
}

src_install() {
	cd src
	emake strip || die "make strip failed"
	python setup.py install --root="${D}" || die "python install failed"
}
