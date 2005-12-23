# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/uptimed/uptimed-0.3.4.ebuild,v 1.1 2005/12/23 20:47:00 ka0ttic Exp $

DESCRIPTION="System uptime record daemon that keeps track of your highest uptimes"
HOMEPAGE="http://podgorny.cz/uptimed/"
SRC_URI="http://podgorny.cz/uptimed/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
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
