# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>, Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysklogd/sysklogd-1.4-r3.ebuild,v 1.4 2001/09/14 05:11:15 lamer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard log daemons"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${P}.tar.gz"

DEPEND="virtual/glibc"
RDEPEND="sys-devel/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/-O3/${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {
	emake LDFLAGS="" || die
}

src_install() {
	dosbin syslogd klogd ${FILESDIR}/syslogd-listfiles
	doman *.[1-9] ${FILESDIR}/syslogd-listfiles.8
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/syslog
	dodoc ANNOUNCE CHANGES COPYING MANIFEST NEWS README.1st README.linux
	exeinto /etc/init.d
	doexe ${FILESDIR}/sysklogd
	insinto /etc
  	doins ${FILESDIR}/syslog.conf
}
