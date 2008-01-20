# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cppcsp2/cppcsp2-2.0.3.ebuild,v 1.1 2008/01/20 09:56:50 dev-zero Exp $

DESCRIPTION="C++CSP2 provides easy concurrency for C++"
HOMEPAGE="http://www.cs.kent.ac.uk/projects/ofa/c++csp/"
SRC_URI="http://www.cs.kent.ac.uk/projects/ofa/c++csp/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		emake docs || die "emake docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README

	use doc && dohtml docs/html/*
}
