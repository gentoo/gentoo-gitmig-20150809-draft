# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/mtink/mtink-1.0.16.ebuild,v 1.2 2010/10/10 18:10:50 ulm Exp $

EAPI="2"
inherit eutils

DESCRIPTION="mtink is a status monitor and inkjet cartridge changer for some Epson printers"
HOMEPAGE="http://xwtools.automatix.de/"
SRC_URI="http://xwtools.automatix.de/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cups doc X"

DEPEND="X? ( x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libXt
		>=x11-libs/openmotif-2.3:0 )
	cups? ( net-print/cups )
	dev-libs/libusb"
RDEPEND="${DEPEND}"

src_prepare() {
	#prevent stripping
	sed -i -e 's:DBG =.*:DBG =:' Makefile.ORG
}

src_configure() {
	./Configure || die
}

src_compile() {
	local mytargets
	mytargets="ttink detect/askPrinter mtinkd"

	if use X; then
		mytargets="${mytargets} mtink mtinkc";
	fi

	make ${mytargets} || die "Compile problem"
}

src_install() {
	dobin ttink detect/askPrinter

	if use X; then
		dobin mtinkc mtink
	fi

	dosbin mtinkd

	newinitd "${FILESDIR}"/mtinkd.rc mtinkd
	newconfd "${FILESDIR}"/mtinkd.confd mtinkd

	if use cups; then
		exeinto /usr/lib/cups/backend
		doexe etc/mtink-cups
	fi

	dodoc README CHANGE.LOG
	use doc && \
		dohtml html/*.gif html/*.html
}

pkg_postinst() {
	# see #70310
	chmod 700 /var/mtink /var/run/mtink 2>/dev/null

	elog
	elog "mtink needs correct permissions to access printer device."
	elog "To do this you either need to run the following chmod command:"
	elog "chmod 666 /dev/<device>"
	elog "or set the suid bit on mtink, mtinkc and ttink in /usr/bin"
	elog
}
