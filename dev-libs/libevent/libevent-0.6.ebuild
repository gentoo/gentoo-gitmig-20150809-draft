# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-0.6.ebuild,v 1.5 2004/02/17 22:05:32 agriffis Exp $

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"
S=${WORKDIR}/${P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fails to compile for me if this file exists
	rm compat/sys/time.h
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dolib libevent.a
	doman event.3
	insinto /usr/include
	doins event.h
}
