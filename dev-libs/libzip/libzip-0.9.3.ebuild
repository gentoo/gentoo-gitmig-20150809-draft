# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzip/libzip-0.9.3.ebuild,v 1.4 2011/03/04 12:06:28 scarabeus Exp $

EAPI=3
inherit autotools-utils libtool

DESCRIPTION="Library for manipulating zip archives"
HOMEPAGE="http://www.nih.at/libzip/"
SRC_URI="http://www.nih.at/libzip/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

DOCS=( NEWS README THANKS AUTHORS )

src_prepare() {
	autotools-utils_src_prepare
	elibtoolize # FreeBSD .so version
}

src_install() {
	autotools-utils_src_install
	remove_libtool_files all
}
