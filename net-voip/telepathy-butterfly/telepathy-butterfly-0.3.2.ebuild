# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-butterfly/telepathy-butterfly-0.3.2.ebuild,v 1.4 2009/01/07 17:11:23 armin76 Exp $

NEED_PYTHON="2.4"

inherit python multilib

DESCRIPTION="An MSN connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/releases/telepathy-butterfly/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/telepathy-python
	>=dev-python/pymsn-0.3.1"

DOCS="AUTHORS NEWS"

src_compile() {
	local myjobs=$(echo "$MAKEOPTS" | sed -n -e 's,.*\(-j[[:digit:]]\+\).*,\1,p')
	./waf --prefix=/usr \
		configure || die "./waf configure failed"
	./waf ${myjobs} build || die "./waf configure failed"
}

src_install() {
	./waf \
		--destdir="${D}" \
		install || die "./waf install failed"
	rm -f $(find "${D}" -name *.py[co])
	dodoc ${DOCS}
}

pkg_postinst() {
	python_version
	python_mod_optimize \
		/usr/$(get_libdir)/python${PYVER}/site-packages/butterfly
}

pkg_postrm() {
	python_mod_cleanup
}
