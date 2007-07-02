# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/swl/swl-0.4.0.ebuild,v 1.2 2007/07/02 15:01:43 peper Exp $

inherit flag-o-matic multilib

DESCRIPTION="SWL is a C++ cross platform library."
HOMEPAGE="http://swl.trapni-akane.org/"
SRC_URI="http://upstream.trapni-akane.org/swl/${P/_/-}.tbz2"
LICENSE="LGPL-2.1"
SLOT="0.4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug ipv6"
RESTRICT="strip"

DEPEND=">=sys-libs/glibc-2.3.4
		>=sys-devel/gcc-3.4.3"

S="${WORKDIR}/${P/_/-}"

src_compile() {
	use debug && append-flags -g3
	use debug || append-flags -DNDEBUG=1

	./configure \
		--prefix="/usr" \
		--host="${CHOST}" \
		--libdir="/usr/$(get_libdir)" \
		--disable-acl \
		--disable-crypto \
		`use_enable ipv6` \
		--without-tests \
		--without-examples \
		|| die "./configure for ABI ${ABI} failed"

	emake || die "make for ABI ${ABI} failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog* NEWS README* TODO
}

# vim:ai:noet:ts=4:nowrap
