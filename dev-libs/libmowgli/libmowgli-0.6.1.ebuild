# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmowgli/libmowgli-0.6.1.ebuild,v 1.9 2011/02/06 19:51:06 chainsaw Exp $

DESCRIPTION="High-performance C development framework. Can be used stand-alone or as a supplement to GLib."
HOMEPAGE="http://www.atheme.org/project/mowgli"
SRC_URI="http://distfiles.atheme.org/${P}.tgz"
IUSE="examples"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

src_compile() {
	econf $(use_enable examples) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS
}
