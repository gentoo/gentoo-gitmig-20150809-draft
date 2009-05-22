# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.6.2.ebuild,v 1.2 2009/05/22 22:39:24 arfrever Exp $

EAPI="2"

DESCRIPTION="HTML documentation for Python"
HOMEPAGE="http://www.python.org/doc/"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/python-${PV}-docs-html.tar.bz2"

LICENSE="PSF-2.2"
SLOT="2.6"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/python-${PV}-docs-html"

src_install() {
	docinto html
	cp -R [a-z]* _static "${D}/usr/share/doc/${PF}/html"
}

pkg_postinst() {
	echo "PYTHONDOCS=/usr/share/doc/${PF}/html/library" > "${ROOT}etc/env.d/50python-docs"
}

pkg_postrm() {
	if ! has_version "<dev-python/python-docs-2.6" && ! has_version ">=dev-python/python-docs-2.7"; then
		rm -f "${ROOT}etc/env.d/50python-docs"
	fi
}
