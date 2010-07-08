# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-butterfly/telepathy-butterfly-0.5.1.ebuild,v 1.6 2010/07/08 15:03:23 arfrever Exp $

PYTHON_DEPEND="2:2.5"

inherit python multilib

DESCRIPTION="An MSN connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/releases/telepathy-butterfly/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-python/telepathy-python-0.15.11
	>=dev-python/papyon-0.4.2"

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
	python_mod_optimize $(python_get_sitedir)/butterfly
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/butterfly
}
