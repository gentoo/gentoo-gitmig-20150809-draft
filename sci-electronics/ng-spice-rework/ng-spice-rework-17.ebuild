# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/ng-spice-rework/ng-spice-rework-17.ebuild,v 1.3 2005/12/28 12:34:54 plasmaroo Exp $

inherit eutils

DESCRIPTION="NGSpice - The Next Generation Spice (Circuit Emulator)"
SRC_URI="ftp://ftp.geda.seul.org/pub/geda/dist/${P}.tar.gz"
HOMEPAGE="http://ngspice.sourceforge.net"
LICENSE="BSD GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/libc"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	for infoFile in doc/ngspice.info*; do
		echo 'INFO-DIR-SECTION EDA' >> ${infoFile}
		echo 'START-INFO-DIR-ENTRY' >> ${infoFile}
		echo '* NGSPICE: (ngspice). Electronic Circuit Simulator.' >> ${infoFile}
		echo 'END-INFO-DIR-ENTRY' >> ${infoFile}
	done

	make DESTDIR="${D}" install || die "make install failed"
	dodoc ANALYSES AUTHORS BUGS COPYING ChangeLog DEVICES \
		NEWS README || die "failed to install documentation"
}

src_test () {
	# Bug 108405
	true
}
