# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-0.7c.ebuild,v 1.10 2004/09/03 15:57:00 pvdabeel Exp $

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha hppa ~ia64 amd64"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fails to compile for me if this file exists
	rm -f compat/sys/time.h
}

src_install() {
	dolib libevent.a || die
	doman event.3
	insinto /usr/include
	doins event.h || die
}
