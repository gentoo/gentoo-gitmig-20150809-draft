# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsaaudio/pyalsaaudio-0.2.ebuild,v 1.3 2007/06/30 03:08:10 lack Exp $

inherit distutils

DESCRIPTION="A Python wrapper for the ALSA API"
HOMEPAGE="http://www.sourceforge.net/projects/pyalsaaudio"
SRC_URI="mirror://sourceforge/pyalsaaudio/${P}.tgz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/alsa-lib"

DOCS="README CHANGES NEWS"


src_install() {
	distutils_src_install

	dohtml -r doc/*

	dodoc doc/src/*.tex

	insinto /usr/share/doc/${PF}/examples
	doins *test.py
}
