# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmowgli/libmowgli-0.9.50.ebuild,v 1.1 2011/01/30 20:01:09 chainsaw Exp $

EAPI=3

DESCRIPTION="High-performance C development framework. Can be used stand-alone or as a supplement to GLib."
HOMEPAGE="http://www.atheme.org/Projects/Libmowgli"
SRC_URI="http://distfiles.atheme.org/${P}.tar.bz2"
IUSE="examples"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

src_configure() {
	econf $(use_enable examples) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README doc/BOOST
}
