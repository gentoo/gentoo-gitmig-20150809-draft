# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmimedir/libmimedir-0.3.ebuild,v 1.2 2003/09/06 22:29:24 msterret Exp $

DESCRIPTION="Library for manipulating MIME directory profiles (RFC2425)"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-devel/flex
	sys-devel/bison"

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	econf
	emake || die
}

src_install() {
	dodir /usr/lib
	dodir /usr/include
	einstall || die "install failed"
	dodoc README
}
