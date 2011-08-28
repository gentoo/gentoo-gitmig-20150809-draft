# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libunwind/libunwind-1.0.ebuild,v 1.2 2011/08/28 15:18:02 naota Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Portable and efficient API to determine the call-chain of a program"
HOMEPAGE="http://savannah.nongnu.org/projects/libunwind"
SRC_URI="http://download.savannah.nongnu.org/releases/libunwind/${P}.tar.gz"

LICENSE="MIT"
SLOT="7"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE="static-libs debug"

RESTRICT="test"		 # https://savannah.nongnu.org/bugs/?22368
					 # https://bugs.gentoo.org/273372

DOCS=( AUTHORS ChangeLog NEWS README TODO )

QA_DT_NEEDED_x86_fbsd="usr/lib/libunwind.so.7.0.0"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-disable-setjmp.patch
	eautoreconf
}

src_configure() {
	local myconf=

	# do not $(use_enable) because the configure.in is broken and parses
	# --disable-debug the same as --enable-debug.
	use debug && myconf+=" --enable-debug"

	econf $(use_enable static-libs static) \
		${myconf}
}

src_test() {
	# explicitly allow parallel build of tests
	emake check
}

src_install() {
	default
	# libunwind-ptrace.a (and libunwind-ptrace.h) is separate API and without
	# shared library, so we keep it in any case
	use static-libs || rm -f "${D}"usr/lib*/libunwind{-generic.a,*.la}
}
