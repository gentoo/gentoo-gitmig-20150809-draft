# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.5.4.ebuild,v 1.6 2009/05/26 01:44:23 jer Exp $

DESCRIPTION="HTML documentation for Python"
HOMEPAGE="http://www.python.org/doc/${PV}/"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/html-${PV}.tar.bz2"

LICENSE="PSF-2.2"
SLOT="2.5"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ppc ~ppc64 ~s390 ~sh sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack html-${PV}.tar.bz2
	rm -f README python.dir
}

src_install() {
	docinto html
	cp -R "${S}/Python-Docs-${PV}/"* "${D}/usr/share/doc/${PF}/html"
}

pkg_postinst() {
	echo "PYTHONDOCS=/usr/share/doc/${PF}/html/lib" > "${ROOT}etc/env.d/50python-docs"
}

pkg_postrm() {
	if ! has_version "<dev-python/python-docs-2.5" && ! has_version ">=dev-python/python-docs-2.6"; then
		rm -f "${ROOT}etc/env.d/50python-docs"
	fi
}
