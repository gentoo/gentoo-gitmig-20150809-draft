# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/uptimed/uptimed-0.3.1.ebuild,v 1.1 2004/02/18 11:20:40 mholzer Exp $

DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="http://unixcode.org/downloads/uptimed/${P}.tar.bz2"
HOMEPAGE="http://unixcode.org/uptimed/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	sed -i -e "s:-d /var/:-d ${D}/var/:g" ${S}/Makefile.am
	sed -i -e "s:-d /var/:-d ${D}/var/:g" ${S}/Makefile.in

	econf || die
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/sbin
	dodir /var/spool/uptimed
	keepdir /var/spool/uptimed

	make DESTDIR=${D} install || die

	dodoc README NEWS TODO AUTHORS COPYING CREDITS
	exeinto /etc/init.d ; newexe ${FILESDIR}/uptimed uptimed
}

pkg_postinst() {
	einfo "To start uptimed, you must enable the /etc/init.d/uptimed rc file"
	einfo "You may start uptimed now with:"
	einfo "/etc/init.d/uptimed start"
	einfo "To view your uptimes, use the command 'uprecords'."
}
