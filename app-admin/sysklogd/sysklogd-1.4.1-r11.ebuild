# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.4.1-r11.ebuild,v 1.1 2004/07/24 21:38:37 azarah Exp $

inherit eutils

DESCRIPTION="Standard log daemons"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64 ppc64 s390"
IUSE=""

DEPEND="virtual/libc"
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
	dodoc ANNOUNCE CHANGES MANIFEST NEWS README.1st README.linux
	dodoc ${FILESDIR}/syslog.conf
	insinto /etc
	doins ${FILESDIR}/syslog.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/sysklogd.rc6 sysklogd
	insinto /etc/conf.d
	newins ${FILESDIR}/sysklogd.confd sysklogd
}
