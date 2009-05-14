# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/cronie/cronie-1.2.ebuild,v 1.2 2009/05/14 16:39:31 bangert Exp $

inherit cron eutils

DESCRIPTION="Cronie is a standard UNIX daemon cron based on the original vixie-cron."
SRC_URI="https://fedorahosted.org/releases/c/r/cronie/${P}.tar.gz"
HOMEPAGE="https://fedorahosted.org/cronie/wiki"

LICENSE="ISC BSD BSD-2"
KEYWORDS="~x86"
IUSE="inotify pam"

DEPEND="pam? ( virtual/pam )"

#cronie supports /etc/crontab
CRON_SYSTEM_CRONTAB="yes"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-pathnames.h-fix-SPOOL_DIR.patch"
}

src_compile() {
	econf \
		$(use_with inotify ) \
		$(use_with pam ) \
		--with-daemon_username=cron \
		--with-daemon_groupname=cron \
		--with-crontabdir=/var/spool/cron/crontabs \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"

	docrondir
	fowners root:cron /usr/bin/crontab
	fperms 2750 /usr/bin/crontab

	insinto /etc
	newins "${FILESDIR}/${P}-crontab" crontab
	newins "${FILESDIR}/${P}-cron.deny" cron.deny

	keepdir /etc/cron.d
	newinitd "${FILESDIR}/${P}-initd" cronie
	dodoc NEWS AUTHORS README
}

pkg_postinst() {
	cron_pkg_postinst
}
