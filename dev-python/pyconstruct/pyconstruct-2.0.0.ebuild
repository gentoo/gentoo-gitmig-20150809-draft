# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyconstruct/pyconstruct-2.0.0.ebuild,v 1.1 2009/02/03 21:05:58 patrick Exp $

inherit python

DESCRIPTION="Simple parsing of binary (and textual) data with Python"
HOMEPAGE="http://construct.wikispaces.com/"

# TODO
# tests are quite large, upstream provides extra dist with them
#SRC_URI="
#	!test? ( mirror://sourceforge/pyconstruct/construct-${PV}-distro.zip )
#	test? ( mirror://sourceforge/pyconstruct/construct-${PV}-full.zip )
#"
# Upstream labels it as 2.00
SRC_URI="mirror://sourceforge/pyconstruct/construct-2.00-distro.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="test"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.5"

S="${WORKDIR}/construct"

src_compile() {
	# Hello World! :-)
	einfo Nothing to compile
}

src_install() {
	# upstream "doesn't believe in setups"
	python_version
	dodir /usr/lib/python${PYVER}/site-packages
	cp -ra "${S}" "${D}"/usr/lib/python${PYVER}/site-packages || die
}

#src_test() {
#	echo TODO :-/
#}

pkg_postinst() {
	python_version
	python_mod_optimize "${ROOT}"usr/lib/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	python_mod_cleanup
}
