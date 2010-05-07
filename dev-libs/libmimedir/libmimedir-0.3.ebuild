# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmimedir/libmimedir-0.3.ebuild,v 1.9 2010/05/07 01:22:34 jer Exp $

inherit multilib

DESCRIPTION="Library for manipulating MIME directory profiles (RFC2425)"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="sys-devel/flex
	sys-devel/bison"
RDEPEND=""

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include
	einstall || die "install failed"
	dodoc README
}
