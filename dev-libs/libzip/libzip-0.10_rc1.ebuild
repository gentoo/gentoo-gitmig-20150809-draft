# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzip/libzip-0.10_rc1.ebuild,v 1.1 2011/03/04 12:17:02 scarabeus Exp $

EAPI=3

MY_P=${P/_}
inherit autotools-utils libtool

DESCRIPTION="Library for manipulating zip archives"
HOMEPAGE="http://www.nih.at/libzip/"
SRC_URI="http://www.nih.at/libzip/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

DOCS=( NEWS README THANKS AUTHORS )

S=${WORKDIR}/${MY_P}

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	autotools-utils_src_prepare
	elibtoolize # FreeBSD .so version
}

src_install() {
	autotools-utils_src_install
	remove_libtool_files all
}
