# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycairo/pycairo-0.9.0.ebuild,v 1.1 2005/08/26 00:04:54 allanonjl Exp $

#inherit distutils

DESCRIPTION="Python wrapper for cairo vector graphics library"
HOMEPAGE="http://cairographics.org/pycairo"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk numeric svg"

DEPEND=">=virtual/python-2.2
	>=x11-libs/cairo-0.9.0
	gtk? ( >=dev-python/pygtk-2.2 )
	svg? ( >=x11-libs/libsvg-cairo-0.1.6 )
	numeric? ( dev-python/numeric )"

src_compile() {
	# dev-python/numeric and libsvg-cairo are automatically 
	# detected by the ./configure script, so don't need to force
	econf $(use_with gtk pygtk)
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"

	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	dodoc AUTHORS NOTES README NEWS ChangeLog
}
