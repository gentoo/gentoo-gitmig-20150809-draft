# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/mtink/mtink-1.0.5.ebuild,v 1.2 2004/11/08 12:08:29 lanius Exp $

DESCRIPTION="mtink is a status monitor and inkjet cartridge changer for some Epson printers"
HOMEPAGE="http://xwtools.automatix.de/"
SRC_URI="http://xwtools.automatix.de/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="doc cups"

DEPEND="x11-libs/openmotif
	virtual/x11
	cups? ( net-print/cups )"

src_compile() {
	make || die "Compile problem"
}

src_install() {
	exeinto /usr/bin
	doexe mtinkc mtink ttink detect/askPrinter

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
	chmod 700 /var/mtink /var/run/mtink 2>/dev/null
}

pkg_postinst() {
	einfo
	einfo "mtink needs correct permissions to access printer device."
	einfo "To do this you either need to run the following chmod command:"
	einfo "chmod 666 /dev/<device>"
	einfo "or set the suid bit on mtink, mtinkc and ttink in /usr/bin"
	einfo
}
