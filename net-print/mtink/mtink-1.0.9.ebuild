# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/mtink/mtink-1.0.9.ebuild,v 1.2 2005/08/09 17:58:11 dholm Exp $

DESCRIPTION="mtink is a status monitor and inkjet cartridge changer for some Epson printers"
HOMEPAGE="http://xwtools.automatix.de/"
SRC_URI="http://xwtools.automatix.de/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cups doc X"

DEPEND="X? ( x11-libs/openmotif virtual/x11 )
	cups? ( net-print/cups )"

inherit eutils

src_compile() {
	local mytargets
	mytargets="ttink detect/askPrinter mtinkd"
	if use X;
		then
	mytargets="${mytargets} mtink mtinkc";
	fi
	make ${mytargets} || die "Compile problem"
}

src_install() {
	exeinto /usr/bin
	if use X; then
		doexe mtinkc mtink ttink detect/askPrinter
	else
		doexe ttink detect/askPrinter
	fi
	exeinto /usr/sbin
	doexe mtinkd
	exeinto /etc/init.d
	newexe ${FILESDIR}/mtinkd.rc mtinkd
	insinto /etc/conf.d
	newins ${FILESDIR}/mtinkd.confd mtinkd

	use cups && \
		exeinto /usr/lib/cups/backend; \
		doexe etc/mtink-cups

	dodoc README CHANGE.LOG LICENCE
	use doc && {
		dohtml html/*.gif html/*.html
	}
}

pkg_postinst() {
	# see #70310
	chmod 700 /var/mtink /var/run/mtink 2>/dev/null

	einfo
	einfo "mtink needs correct permissions to access printer device."
	einfo "To do this you either need to run the following chmod command:"
	einfo "chmod 666 /dev/<device>"
	einfo "or set the suid bit on mtink, mtinkc and ttink in /usr/bin"
	einfo
}
