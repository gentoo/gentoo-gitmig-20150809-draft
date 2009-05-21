# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsaaudio/pyalsaaudio-0.4.ebuild,v 1.2 2009/05/21 17:55:53 fmccor Exp $

inherit distutils

DESCRIPTION="A Python wrapper for the ALSA API"
HOMEPAGE="http://www.sourceforge.net/projects/pyalsaaudio"
SRC_URI="mirror://sourceforge/pyalsaaudio/${P}.tar.gz"
LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="media-libs/alsa-lib"
RDEPEND="${DEPEND}"

DOCS="CHANGES"

src_install() {
	distutils_src_install

	dohtml -r doc/*

	dodoc doc/src/*.tex

	insinto /usr/share/doc/${PF}/examples
	doins *test.py
}
