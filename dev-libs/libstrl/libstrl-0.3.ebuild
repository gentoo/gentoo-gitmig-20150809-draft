# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstrl/libstrl-0.3.ebuild,v 1.1 2011/01/21 18:17:53 hwoarang Exp $

EAPI=3

inherit autotools-utils multilib

DESCRIPTION="Compat library for functions like strlcpy(), strlcat(), and strnlen()"
HOMEPAGE="http://ohnopub.net/~ohnobinki/libstrl/"
SRC_URI="ftp://ohnopub.net/mirror/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x64-macos"
IUSE="doc static-libs test"

DEPEND="doc? ( app-doc/doxygen )
	test? ( dev-libs/check )"
RDEPEND=""

src_configure() {
	local myeconfargs=(
		$(use_with doc doxygen)
		$(use_with test check)
	)

	autotools-utils_src_configure
}
