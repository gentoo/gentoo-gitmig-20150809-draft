# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/driftnet/driftnet-0.1.6.ebuild,v 1.1 2002/07/19 04:23:43 spider Exp $

DESCRIPTION="Driftnet is a program which listens to network traffic and picks out images from TCP streams it observes."
HOMEPAGE="http://www.ex-parrot.com/~chris/driftnet/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"


DEPEND="media-libs/jpeg
		media-libs/libungif
		net-libs/libpcap
		gtk? ( <x11-libs/gtk+-1.3.0 )"

		
RDEPEND="media-sound/mpg123"
SRC_URI="http://www.ex-parrot.com/~chris/${PN}/${P}.tar.gz"

S=${WORKDIR}/${P}

src_compile() {
	if [ `use gtk` ] 
	then
		emake || die "gtk+ build failed"
		mv driftnet driftnet-gtk
		make clean
	fi
	patch -p1 <${FILESDIR}/${P}-nogtk.patch
	emake || die
}

src_install () {
	dobin driftnet
	doman driftnet.1
	use gtk && dobin driftnet-gtk
	dodoc CHANGES COPYING CREDITS README TODO

	einfo "marking the no-display driftnet as setuid root."
	chown root.wheel ${D}/usr/bin/driftnet
	chmod 750 ${D}/usr/bin/driftnet
	chmod u+s ${D}/usr/bin/driftnet
	
}

