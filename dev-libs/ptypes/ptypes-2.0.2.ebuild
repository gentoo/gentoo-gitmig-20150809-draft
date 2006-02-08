# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ptypes/ptypes-2.0.2.ebuild,v 1.2 2006/02/08 05:22:17 halcy0n Exp $

DESCRIPTION="PTypes (C++ Portable Types Library) is a simple alternative to the STL that includes multithreading and networking."

HOMEPAGE="http://www.melikyan.com/ptypes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

src_install() {
	dolib lib/* || die "Installing libraries"
	insinto /usr/include
	doins include/* || die "Installing headers"
	dohtml -r doc/* || die "Installing documentation"
}
