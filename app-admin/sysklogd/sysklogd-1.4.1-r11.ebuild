# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.4.1-r11.ebuild,v 1.7 2007/02/11 13:10:14 vapier Exp $

inherit eutils

DESCRIPTION="Standard log daemons"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""
RESTRICT="test"

DEPEND=""
RDEPEND="dev-lang/perl
	sys-apps/debianutils"
PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i \
		-e "s:-O3:${CFLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE:" \
		Makefile || die "sed CFLAGS"

	# Handle SO_BSDCOMPAT being depricated in 2.5+ kernels.
	epatch "${FILESDIR}"/${P}-SO_BSDCOMPAT.patch
	epatch "${FILESDIR}"/${P}-2.6.headers.patch
	epatch "${FILESDIR}"/${PN}-1.4.1-mips.patch
}

src_compile() {
	emake LDFLAGS="" || die
}

src_install() {
	dosbin syslogd klogd "${FILESDIR}"/syslogd-listfiles || die "dosbin"
	doman *.[1-9] "${FILESDIR}"/syslogd-listfiles.8
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/syslog-cron syslog.cron
	dodoc ANNOUNCE CHANGES MANIFEST NEWS README.1st README.linux
	dodoc "${FILESDIR}"/syslog.conf
	insinto /etc
	doins "${FILESDIR}"/syslog.conf
	newinitd "${FILESDIR}"/sysklogd.rc6 sysklogd
	newconfd "${FILESDIR}"/sysklogd.confd sysklogd
}
