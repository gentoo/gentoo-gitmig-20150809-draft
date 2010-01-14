# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler/python-poppler-0.12.1.ebuild,v 1.1 2010/01/14 02:44:35 yngwin Exp $

EAPI="2"

NEED_PYTHON="2.6"
PYTHON_DEFINE_DEFAULT_FUNCTIONS="1"
SUPPORT_PYTHON_ABIS="1"

inherit libtool python

DESCRIPTION="Python bindings to the Poppler PDF library."
SRC_URI="http://launchpad.net/poppler-python/trunk/development/+download/pypoppler-${PV}.tar.gz"
HOMEPAGE="http://launchpad.net/poppler-python"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

S="${WORKDIR}/pypoppler-${PV}"

RDEPEND=">=virtual/poppler-glib-0.12.0
	dev-python/pygobject:2
	dev-python/pygtk:2
	>=dev-python/pycairo-1.8.4"
DEPEND="${RDEPEND}"

RESTRICT_PYTHON_ABIS="2.4 2.5 3*"

src_prepare() {
	elibtoolize
	python_copy_sources
}

src_install() {
	python_src_install
	find "${D}" -name '*.la' -type f -exec rm -f '{}' ';' || die "Removing .la files failed"
	dodoc NEWS
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/demo-poppler.py
	fi
}
