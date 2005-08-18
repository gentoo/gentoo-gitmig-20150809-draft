# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigcx/libsigcx-0.6.5.ebuild,v 1.1 2005/08/18 20:25:22 ka0ttic Exp $

inherit eutils

RESTRICT="test"

DESCRIPTION="An extension of libsigc++ that provides type-safe cross-thread signal/slot support"
HOMEPAGE="http://libsigcx.sourceforge.net/"
SRC_URI="mirror://sourceforge/libsigcx/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug doc gtk threads"

DEPEND="dev-libs/libsigc++
	doc? ( app-doc/doxygen )
	gtk? ( >=x11-libs/gtk+-2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-missing-friend.diff

	# don't build docs unconditionally
	sed -i -e 's|\(SUBDIRS = .*\)@MAYBE_DOC@\(.*\)$|\1\2|' Makefile.in || \
		die "sed docs failed"

	# don't build tests unless USE=test
#    if ! use test ; then
		sed -i -e 's|\(SUBDIRS = .*\)tests\(.*\)$|\1\2|' Makefile.in || \
			die "sed tests failed"
#    fi
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_with threads) \
		$(use_with gtk) \
		|| die "econf failed"

	emake || die "emake failed"

	if use doc ; then
		cd doc
		emake || die "failed to build api documentation"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS

	if use doc ; then
		dohtml -r doc/html/*
		docinto examples
		dodoc examples/*.{cc,h} examples/README
	fi
}
