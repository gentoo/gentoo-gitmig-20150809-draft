# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycairo/pycairo-1.0.2.ebuild,v 1.14 2006/09/04 01:12:22 kumba Exp $

DESCRIPTION="Python wrapper for cairo vector graphics library"
HOMEPAGE="http://cairographics.org/pycairo"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="gtk numeric svg"

DEPEND=">=dev-lang/python-2.3
	=x11-libs/cairo-1.0*
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
	doins -r examples/*
	rm ${D}/usr/share/doc/${PF}/examples/Makefile*

	dodoc AUTHORS NOTES README NEWS ChangeLog
}
