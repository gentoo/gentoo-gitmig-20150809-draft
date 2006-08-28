# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol-sound-server/pysol-sound-server-3.01.ebuild,v 1.4 2006/08/28 00:10:52 kumba Exp $

DESCRIPTION="Sound server for PySol"
HOMEPAGE="http://www.oberhumer.com/opensource/pysol/"
SRC_URI="http://www.oberhumer.com/opensource/pysol/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 mips ppc ppc64 x86"
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
	dodoc NEWS README
	cd src
	python setup.py install --root="${D}" || die "python install failed"
}
