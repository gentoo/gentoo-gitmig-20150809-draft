# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmowgli/libmowgli-0.7.0.ebuild,v 1.7 2008/12/13 18:23:44 klausman Exp $

DESCRIPTION="High-performance C development framework. Can be used stand-alone or as a supplement to GLib."
HOMEPAGE="http://www.atheme.org/Projects/Libmowgli"
SRC_URI="http://distfiles.atheme.org/${P}.tbz2"
IUSE="examples"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ~ppc ppc64 sparc x86 ~x86-fbsd"

src_compile() {
	econf $(use_enable examples) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README doc/BOOST
}
