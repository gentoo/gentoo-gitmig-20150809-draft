# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hpijs/hpijs-1.3.1.ebuild,v 1.2 2003/09/07 00:18:10 msterret Exp $

# Though this program runs on it's own it makes no sense to run it without ghostscript

S=${WORKDIR}/${P}
DESCRIPTION="The HP Inkjet server for Ghostscript. Provides best output for HP Inkjet Printers"
HOMEPAGE="http://hpinkjet.sourceforge.net"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
SRC_URI="mirror://sourceforge/hpinkjet/${P}.tar.gz"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND} app-text/ghostscript"
LICENSE="as-is"
SLOT="0"

src_compile () {
	econf
	make || die "compile problem"
}

src_install () {
	einstall || die
	# fix the doc dir, it needs to have the package revision..
	mv ${D}/usr/share/doc/${P} ${D}/usr/share/doc/${PF}
}

pkg_postinst () {
	if [ "`use cups`" ] ; then
		einfo "To use the hpijs driver with the cups spooler, you will need the .ppd file"
		einfo "for your printer.  You may obtain it from:"
		einfo "http://www.linuxprinting.org/show_driver.cgi?driver=hpijs"
		einfo "Install it in /usr/share/cups/model.  After restarting cups you should be"
		einfo "able to use the new driver."
	else
		einfo "To use the hpijs driver with the PDQ spooler you will need the PDQ driver file"
		einfo "for your printer from http://www.linuxprinting.org/show_driver.cgi?driver=hpijs"
		einfo "This file should be installed in /etc/pdq/drivers"
	fi
}
