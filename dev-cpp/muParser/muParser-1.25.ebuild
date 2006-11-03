# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/muParser/muParser-1.25.ebuild,v 1.4 2006/11/03 15:46:12 caleb Exp $

DESCRIPTION="Library for parsing mathematical expressions"
HOMEPAGE="http://muparser.sourceforge.net/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86"
IUSE="doc"
MY_PN="${PN/P/p}"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}.tar.gz"
DEPEND="doc? ( app-doc/doxygen )"
S="${WORKDIR}/${PN}"

src_compile() {
	econf --disable-samples || die "econf failed"
	MAKEOPTS="$MAKEOPTS -j1" emake CXXFLAGS="${CXXFLAGS}" || die "emake failed"
	if use doc; then
		make documentation || die "make documentation failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	if use doc; then
		insinto "/usr/share/doc/${PF}"
		doins -r docs/html
	fi
}
