# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/driftnet/driftnet-0.1.6.ebuild,v 1.17 2005/03/18 14:19:35 ka0ttic Exp $

inherit eutils flag-o-matic

DESCRIPTION="A program which listens to network traffic and picks out images from TCP streams it observes"
HOMEPAGE="http://www.ex-parrot.com/~chris/driftnet/"
SRC_URI="http://www.ex-parrot.com/~chris/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64 ppc"
SLOT="0"
IUSE="gtk"

DEPEND="media-libs/jpeg
		media-libs/giflib
		virtual/libpcap
		gtk? ( <x11-libs/gtk+-1.3.0 )"
RDEPEND="${DEPEND}
	virtual/mpg123"

src_unpack() {
	unpack ${A}
	cd ${S}

	# use giflib - bug 85720
	sed -i 's/-lungif/-lgif/' Makefile || die "sed giflib failed"
	# don't use gtk+ by default
	sed -i 's:^\(.*gtk-config.*\)$:#\1:g' Makefile || die "sed disable gtk failed"

	epatch ${FILESDIR}/${P}-tmpnam-is-bad.diff
}

src_compile() {
	append-ldflags -Wl,-z,now

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
