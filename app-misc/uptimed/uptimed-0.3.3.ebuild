# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/uptimed/uptimed-0.3.3.ebuild,v 1.10 2005/03/24 19:31:00 kloeri Exp $

DESCRIPTION="System uptime record daemon that keeps track of your highest uptimes"
HOMEPAGE="http://unixcode.org/uptimed/"
SRC_URI="http://unixcode.org/downloads/uptimed/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 sparc ~ppc64 ~alpha"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-d /var/:-d ${D}/var/:" Makefile.in || die
}

src_install() {
	make DESTDIR=${D} install || die
	keepdir /var/spool/uptimed
	dodoc ChangeLog README TODO AUTHORS CREDITS INSTALL.cgi sample-cgi/*
	doinitd ${FILESDIR}/uptimed || die
}

pkg_postinst() {
	echo
	einfo "Start uptimed with '/etc/init.d/uptimed start'"
	einfo "To view your uptime records, use the command 'uprecords'."
	echo
}
