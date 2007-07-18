# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ttfquery/ttfquery-1.0.0-r1.ebuild,v 1.1 2007/07/18 23:37:05 hawking Exp $

inherit distutils
MY_PN="TTFQuery"

DESCRIPTION="Font metadata and glyph outline extraction utility library"
HOMEPAGE="http://ttfquery.sourceforge.net/"
SRC_URI="mirror://sourceforge/ttfquery/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86" # should work on all architectures

IUSE=""
DEPEND="virtual/python
	>=dev-python/fonttools-2.0_beta1-r1
	>=dev-python/numpy-1.0.2"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	distutils_src_unpack

	sed -i \
		-e "s/Numeric/numpy.oldnumeric/" \
		glyph.py || die "sed failed"
}

pkg_postinst() {
	ewarn "This version uses numpy.oldnumeric instead of the numeric module."
	ewarn "If this causes any unforeseen problems please file a bug on"
	ewarn "http://bugs.gentoo.org."
}
