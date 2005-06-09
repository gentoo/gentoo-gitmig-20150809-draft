# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-1.1.ebuild,v 1.2 2005/06/09 13:54:06 ka0ttic Exp $

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

pkg_setup() {
	prevver=$(best_version ${CATEGORY}/${PN})
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}

pkg_postinst() {
	if [[ -n "${prevver}" ]] ; then
		ewarn
		ewarn "You will need to run revdep-rebuild (included with app-portage/gentoolkit)"
		ewarn "to rebuild all packages that were built with libevent-1.0x."
		ewarn
		ewarn "Run the following to see which packages will be rebuilt:"
		ewarn "    revdep-rebuild --soname ${prevver##*/}.so.1 -p"
		ewarn
		ewarn "If you are satisfied with the output, re-run without the '-p' to rebuild."
		ewarn
		unset prevver
	fi
}
