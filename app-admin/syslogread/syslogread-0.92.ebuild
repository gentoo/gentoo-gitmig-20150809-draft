# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslogread/syslogread-0.92.ebuild,v 1.5 2008/01/25 23:34:13 bangert Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Syslog message handling tools"
HOMEPAGE="http://untroubled.org/syslogread/"
SRC_URI="http://untroubled.org/syslogread/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/bglibs-1.019-r1"
RDEPEND="sys-process/daemontools"
PROVIDE="virtual/logger"

pkg_preinst() {
	enewgroup syslog
	enewuser syslog -1 -1 /nonexistent syslog
}

src_compile() {
	echo "/usr/include/bglibs/" > conf-bgincs
	echo "/usr/lib/bglibs/" > conf-bglibs
	echo "${D}/usr/bin" > conf-bin
	echo "${D}/usr/share/man" > conf-man
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	make || die  #don't use emake b/c of jobserver
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man
	./installer || die

	#newinitd "${FILESDIR}/${PV}/syslogread.init" syslogread

	dodoc ANNOUNCEMENT ChangeLog README

	insinto /var/lib/supervise/klogd
	newins "${FILESDIR}/${PV}/klogd.run" klogd.run

	insinto /var/lib/supervise/syslogd
	newins "${FILESDIR}/${PV}/syslogread.run" syslogread.run

	insinto /var/lib/supervise/syslogd/log
	newins "${FILESDIR}/${PV}/syslogread-log.run" syslogread-log.run

	keepdir /var/log/klogd
	keepdir /var/log/syslog

	fowners syslog:syslog /var/log/syslog
	fperms o-rwx /var/log/syslog
}

pkg_postinst() {
	echo
	elog "Run "
	elog "emerge --config =${PF}"
	elog "to create or update your run files (backups are created) in"
	elog "    /var/lib/supervise/klogd (kernel logger)"
	elog "    /var/lib/supervise/syslog (system logger)"
	echo
}

pkg_config() {
	cd "${ROOT}"var/lib/supervise/klogd
	[ -e run ] && cp run klogd.run.`date +%Y%m%d%H%M%S`
	cp klogd.run run
	chmod u+x run

	cd "${ROOT}"var/lib/supervise/syslogd
	[ -e run ] && cp run syslogread.run.`date +%Y%m%d%H%M%S`
	cp syslogread.run run
	chmod u+x run

	cd "${ROOT}"var/lib/supervise/syslogd/log
	[ -e run ] && cp run syslogread-log.run.`date +%Y%m%d%H%M%S`
	cp syslogread-log.run run
	chmod u+x run
}
