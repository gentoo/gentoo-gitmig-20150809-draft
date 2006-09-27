# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/uptimed/uptimed-0.3.3.ebuild,v 1.16 2006/09/27 09:21:51 caster Exp $

WANT_AUTOMAKE=1.5

inherit autotools

DESCRIPTION="System uptime record daemon that keeps track of your highest uptimes"
HOMEPAGE="http://podgorny.cz/uptimed/"
SRC_URI="http://podgorny.cz/uptimed/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 mips ppc ppc64 sparc x86"
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
