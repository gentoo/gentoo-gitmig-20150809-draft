# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzip/libzip-0.9.3.ebuild,v 1.3 2010/12/21 19:23:37 graaff Exp $

EAPI=2
inherit libtool

DESCRIPTION="Library for manipulating zip archives"
HOMEPAGE="http://www.nih.at/libzip/"
SRC_URI="http://www.nih.at/libzip/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

src_prepare() {
	elibtoolize # FreeBSD .so version
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README THANKS AUTHORS
}
