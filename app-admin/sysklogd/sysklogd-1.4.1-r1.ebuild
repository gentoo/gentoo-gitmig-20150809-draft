# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.4.1-r1.ebuild,v 1.1 2002/09/23 00:27:57 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard log daemons"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${P}.tar.gz"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
KEYWORDS="x86"
SLOT="0"
LICENSE="BSD"
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
	newexe ${FILESDIR}/syslog-cron syslog
	dodoc ANNOUNCE CHANGES COPYING MANIFEST NEWS README.1st README.linux
	dodoc ${FILESDIR}/syslog.conf
	insinto /etc
  	doins ${FILESDIR}/syslog.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/sysklogd.rc6 sysklogd
	insinto /etc/conf.d
	newins ${FILESDIR}/sysklogd.confd sysklogd
}
