# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/driftnet/driftnet-0.1.6.ebuild,v 1.13 2004/07/31 22:07:52 malc Exp $

inherit eutils

DESCRIPTION="A program which listens to network traffic and picks out images from TCP streams it observes"
HOMEPAGE="http://www.ex-parrot.com/~chris/driftnet/"
SRC_URI="http://www.ex-parrot.com/~chris/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64"
SLOT="0"
IUSE="gtk"

DEPEND="media-libs/jpeg
		media-libs/libungif
		net-libs/libpcap
		gtk? ( <x11-libs/gtk+-1.3.0 )"
RDEPEND="virtual/mpg123"

src_compile() {
	if use gtk; then
		emake || die "gtk+ build failed"
		mv driftnet driftnet-gtk
		make clean || die
	fi
	epatch "${FILESDIR}/${P}-nogtk.patch"
	emake || die "emake failed"
}

src_install () {
	dobin driftnet || die "dobin failed"
	doman driftnet.1 || die "doman failed"
	if use gtk ; then
		dobin driftnet-gtk || die "dobin failed (gtk)"
	fi
	dodoc CHANGES CREDITS README TODO || die "dodoc failed"

	einfo "marking the no-display driftnet as setuid root."
	chown root:wheel "${D}/usr/bin/driftnet"
	chmod 750 "${D}/usr/bin/driftnet"
	chmod u+s "${D}/usr/bin/driftnet"
}
