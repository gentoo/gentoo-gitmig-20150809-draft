# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-musicbrainz/python-musicbrainz-20050108-r1.ebuild,v 1.2 2008/09/12 16:01:54 jer Exp $

inherit distutils

DESCRIPTION="Python bindings for musicbrainz client library"
HOMEPAGE="http://musicbrainz.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~x86"

IUSE="examples"
DEPEND="=media-libs/musicbrainz-2*
	|| ( >=dev-lang/python-2.5
		( >=dev-lang/python-2.3 >=dev-python/ctypes-0.9.2 )
	)"

S=${WORKDIR}/${PN}

src_install() {
	distutils_src_install
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp examples/* "${D}"/usr/share/doc/${PF}/examples/
	fi
}
