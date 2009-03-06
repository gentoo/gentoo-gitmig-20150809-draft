# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cppcsp2/cppcsp2-2.0.5.ebuild,v 1.1 2009/03/06 15:08:33 dev-zero Exp $

EAPI="2"

DESCRIPTION="C++CSP2 provides easy concurrency for C++"
HOMEPAGE="http://www.cs.kent.ac.uk/projects/ofa/c++csp/"
SRC_URI="http://www.cs.kent.ac.uk/projects/ofa/c++csp/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND="dev-libs/boost"
DEPEND="doc? ( app-doc/doxygen )
	${RDEPEND}"

src_compile() {
	default
	if use doc ; then
		emake docs || die "emake docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README

	use doc && dohtml docs/html/*
}
