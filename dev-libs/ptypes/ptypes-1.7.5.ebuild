# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ptypes/ptypes-1.7.5.ebuild,v 1.1 2003/03/14 04:51:29 george Exp $

DESCRIPTION="PTypes (C++ Portable Types Library) is a simple alternative to the STL that includes multithreading and networking."

HOMEPAGE="http://www.melikyan.com/ptypes/"
SRC_URI="http://easynews.dl.sourceforge.net/sourceforge/ptypes/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	make
}

src_install() {
	dolib lib/* || die
	insinto /usr/include
	doins include/* || die
	dohtml doc/* || die

	dodoc LICENSE
}
