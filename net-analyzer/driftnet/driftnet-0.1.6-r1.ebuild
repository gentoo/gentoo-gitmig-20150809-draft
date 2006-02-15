# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/driftnet/driftnet-0.1.6-r1.ebuild,v 1.2 2006/02/15 22:02:06 jokey Exp $

inherit eutils flag-o-matic

DESCRIPTION="A program which listens to network traffic and picks out images from TCP streams it observes"
HOMEPAGE="http://www.ex-parrot.com/~chris/driftnet/"
SRC_URI="http://www.ex-parrot.com/~chris/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE="gtk"

DEPEND="media-libs/jpeg
	media-libs/giflib
	net-libs/libpcap
	gtk? ( <x11-libs/gtk+-1.3.0 )
	|| (
	( >=x11-misc/makedepend-1.0.0 )
	virtual/x11
	)"

# Note: x11 is necessary because of makedepend

RDEPEND="${DEPEND}
	virtual/mpg123"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# use giflib - bug 85720
	sed -i 's/-lungif/-lgif/' Makefile || die "sed giflib failed"
	# don't use gtk+ by default
	sed -i 's:^\(.*gtk-config.*\)$:#\1:g' Makefile || die "sed disable gtk failed"

	epatch "${FILESDIR}"/${P}-tmpnam-is-bad.diff
}

src_compile() {
	append-ldflags $(bindnow-flags)

	if use gtk; then
		sed -i 's:^#\(.*gtk-config.*\)$:\1:g' Makefile || die "sed enable gtk failed"
		emake || die "gtk+ build failed"
		mv driftnet driftnet-gtk
		make clean || die
	else
		append-flags -DNO_DISPLAY_WINDOW
	fi

	emake || die "emake failed"
}

src_install () {
	dobin driftnet || die "dobin failed"
	doman driftnet.1 || die "doman failed"

	use gtk && { dobin driftnet-gtk || die "dobin failed (gtk)" ; }

	dodoc CHANGES CREDITS README TODO || die "dodoc failed"

	einfo "marking the no-display driftnet as setuid root."
	chown root:wheel "${D}/usr/bin/driftnet"
	chmod 750 "${D}/usr/bin/driftnet"
	chmod u+s "${D}/usr/bin/driftnet"
}
