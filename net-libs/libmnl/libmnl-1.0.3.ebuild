# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmnl/libmnl-1.0.3.ebuild,v 1.4 2012/12/01 17:57:11 armin76 Exp $

EAPI=4

inherit multilib

DESCRIPTION="Minimalistic netlink library"
HOMEPAGE="http://netfilter.org/projects/libmnl"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

src_configure() {
	econf \
		--libdir="${EPREFIX}"/$(get_libdir)
}

src_install() {
	default
	dodir /usr/$(get_libdir)/pkgconfig/
	mv "${ED}"/{,usr/}$(get_libdir)/pkgconfig/libmnl.pc || die

	if use examples; then
		find examples/ -name "Makefile*" -exec rm -f '{}' +
		dodoc -r examples/
		docompress -x /usr/share/doc/${P}/examples
	fi

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
