# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/uptimed/uptimed-0.3.3.ebuild,v 1.1 2004/09/11 18:03:44 ka0ttic Exp $

DESCRIPTION="Standard informational utilities and process-handling tools"
HOMEPAGE="http://unixcode.org/uptimed/"
SRC_URI="http://unixcode.org/downloads/uptimed/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

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

	dodoc README NEWS TODO AUTHORS CREDITS
	dodoc INSTALL.cgi sample-cgi/*
	exeinto /etc/init.d ; newexe ${FILESDIR}/uptimed uptimed
}

pkg_postinst() {
	einfo "To start uptimed, you must enable the /etc/init.d/uptimed rc file"
	einfo "You may start uptimed now with:"
	einfo "/etc/init.d/uptimed start"
	einfo "To view your uptimes, use the command 'uprecords'."
}
