# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-butterfly/telepathy-butterfly-0.3.0.ebuild,v 1.1 2008/01/13 20:26:29 coldwind Exp $

NEED_PYTHON="2.4"

inherit python

DESCRIPTION="An MSN connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/releases/telepathy-butterfly/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/telepathy-python
	>=dev-python/pymsn-0.3.0"

DOCS="AUTHORS NEWS"

src_compile() {
	./waf --prefix=/usr \
		configure || die "./waf configure failed"
	./waf ${MAKEOPTS} build || die "./waf configure failed"
}

src_install() {
	./waf \
		--destdir="${D}" \
		install || die "./waf install failed"
	rm -f $(find "${D}" -name *.py[co])
	dodoc ${DOCS}
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
