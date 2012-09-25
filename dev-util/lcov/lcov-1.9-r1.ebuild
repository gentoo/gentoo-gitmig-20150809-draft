# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lcov/lcov-1.9-r1.ebuild,v 1.5 2012/09/25 11:31:36 blueness Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A graphical front-end for GCC's coverage testing tool gcov"
HOMEPAGE="http://ltp.sourceforge.net/coverage/lcov.php"
SRC_URI="mirror://sourceforge/ltp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5
	dev-perl/GD[png]"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch
}

src_compile() { :; }

src_install() {
	emake PREFIX="${D}" install
}
