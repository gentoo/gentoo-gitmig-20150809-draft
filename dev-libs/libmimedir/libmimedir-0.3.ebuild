# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmimedir/libmimedir-0.3.ebuild,v 1.7 2005/04/09 23:41:21 kugelfang Exp $

inherit multilib

DESCRIPTION="Library for manipulating MIME directory profiles (RFC2425)"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="sys-devel/flex
	sys-devel/bison"

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
