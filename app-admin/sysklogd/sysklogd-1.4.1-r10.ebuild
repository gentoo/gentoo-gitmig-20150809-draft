# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.4.1-r10.ebuild,v 1.10 2004/03/29 23:19:31 mr_bones_ Exp $

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Standard log daemons"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc ~alpha hppa mips ia64 amd64 ppc64"

DEPEND="virtual/glibc"
RDEPEND="dev-lang/perl sys-apps/debianutils"

PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "s:-O3:${CFLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE:" Makefile

	# Handle SO_BSDCOMPAT being depricated in 2.5+ kernels.
	cd ${S}; epatch ${FILESDIR}/${P}-SO_BSDCOMPAT.patch
	cd ${S}; epatch ${FILESDIR}/${P}-2.6.headers.patch

	if [ "${ARCH}" = "mips" ]
	then
	   cd ${S}
	    epatch ${FILESDIR}/${PN}-1.4.1-mips.patch
	 fi
}

src_compile() {
	emake LDFLAGS="" || die
}

src_install() {
	dosbin syslogd klogd ${FILESDIR}/syslogd-listfiles
	doman *.[1-9] ${FILESDIR}/syslogd-listfiles.8
	exeinto /etc/cron.daily
	newexe ${FILESDIR}/syslog-cron syslog.cron
	dodoc ANNOUNCE CHANGES COPYING MANIFEST NEWS README.1st README.linux
	dodoc ${FILESDIR}/syslog.conf
	insinto /etc
	doins ${FILESDIR}/syslog.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/sysklogd.rc6 sysklogd
	insinto /etc/conf.d
	newins ${FILESDIR}/sysklogd.confd sysklogd
}
