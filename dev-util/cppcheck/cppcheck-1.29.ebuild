# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppcheck/cppcheck-1.29.ebuild,v 1.1 2009/03/06 20:13:04 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="static analyzer of C/C++ code"
HOMEPAGE="http://apps.sourceforge.net/trac/cppcheck/"
SRC_URI="mirror://sourceforge/cppcheck/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i \
		-e '/^CXXFLAGS/s:=:+=:' \
		-e 's:g++:$(CXX):' \
		Makefile
	tc-export CXX
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc readme.txt
}
