# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack/jack-3.0.0.ebuild,v 1.2 2004/02/15 13:05:17 dholm Exp $

inherit distutils

DESCRIPTION="A frontend for several cd-rippers and mp3 encoders"
HOMEPAGE="http://www.home.unix-ag.org/arne/jack/"
SRC_URI="http://www.home.unix-ag.org/arne/jack/${P}.tar.gz"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=virtual/python-1.5.2
	dev-python/cddb-py
	dev-python/id3-py
	media-libs/flac
	media-libs/libogg
	media-libs/libvorbis
	media-sound/lame
	media-sound/cdparanoia"

src_compile() {
	python setup-cursesmodule.py build || die "compilation failed"
}

src_install() {
	python setup-cursesmodule.py install --root=${D} \
		|| die "curses module install failed"

	dobin jack

	distutils_python_version
	dodir /usr/lib/python${PYVER}/site-packages
	insinto /usr/lib/python${PYVER}/site-packages
	doins jack_*py

	newman jack.man jack.1

	dodoc README doc/ChangeLog doc/INSTALL doc/TODO

	dohtml doc/*html doc/*css doc/*gif
}
