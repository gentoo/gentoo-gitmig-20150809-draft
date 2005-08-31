# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-musicbrainz/python-musicbrainz-20050108.ebuild,v 1.2 2005/08/31 17:58:57 swegener Exp $

inherit distutils

DESCRIPTION="Python bindings for musicbrainz client library"
HOMEPAGE="http://musicbrainz.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=media-libs/musicbrainz-2.1.1
	>=dev-python/ctypes-0.9.2
	>=dev-lang/python-2.3"
S=${WORKDIR}/${PN}

src_install() {
	distutils_src_install
	dodir /usr/share/doc/${PF}/examples
	cp examples/* ${D}/usr/share/doc/${PF}/examples/
	prepalldocs
}
