# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-0.7c.ebuild,v 1.4 2004/02/20 08:02:54 vapier Exp $

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa ~ia64 ~amd64"

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
