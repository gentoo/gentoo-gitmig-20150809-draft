# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtest/gtest-1.4.0.ebuild,v 1.1 2010/03/01 23:54:29 matsuu Exp $

EAPI="2"
inherit autotools eutils

DESCRIPTION="Google C++ Testing Framework"
HOMEPAGE="http://code.google.com/p/googletest/"
SRC_URI="http://googletest.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-asneeded.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc CHANGES CONTRIBUTORS README || die
}
