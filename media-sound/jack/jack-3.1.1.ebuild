# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack/jack-3.1.1.ebuild,v 1.1 2005/03/19 13:15:36 luckyduck Exp $

IUSE=""

inherit distutils

DESCRIPTION="A frontend for several cd-rippers and mp3 encoders"
HOMEPAGE="http://www.home.unix-ag.org/arne/jack/"
SRC_URI="http://www.home.unix-ag.org/arne/jack/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=virtual/python-1.5.2
	sys-libs/ncurses"

RDEPEND="${DEPEND}
	dev-python/cddb-py
	dev-python/id3-py
	dev-python/pyid3lib
	dev-python/pyvorbis
	media-libs/flac
	media-sound/lame
	media-sound/cdparanoia"

src_compile() {
	python setup.py build || die "compilation failed"
}

src_install() {
	python setup.py install --root=${D} \
		|| die "installation failed"

	dobin jack

	distutils_python_version
	dodir /usr/$(get_libdir)/python${PYVER}/site-packages
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	doins jack_*py

	newman jack.man jack.1

	dodoc README doc/ChangeLog doc/INSTALL doc/TODO

	dohtml doc/*html doc/*css doc/*gif
}
