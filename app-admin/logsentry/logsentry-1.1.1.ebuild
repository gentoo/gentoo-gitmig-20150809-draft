# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logsentry/logsentry-1.1.1.ebuild,v 1.8 2003/02/13 05:26:13 vapier Exp $

S=${WORKDIR}/logcheck-${PV}
DESCRIPTION="LogSentry automatically monitors your system logs and mails security violations to you on a periodic basis"
HOMEPAGE="http://www.psionic.com/products/logsentry.html/"
SRC_URI="http://www.psionic.com/downloads/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

DEPEND="sys-apps/supersed"
RDEPEND="${DEPEND}
	net-mail/mailx"

src_compile() {

	echo "compile and install mixed in the package makefile"
}

src_install() {

	dodir /usr/bin /etc/logcheck/tmp /etc/cron.hourly
	ssed -i -e 's:/usr/local/bin:/usr/bin:' \
		-e 's:/usr/local/etc:/etc/logcheck:' \
		${S}/systems/linux/logcheck.sh || die
	ssed -i -e "s:/usr/local/bin:${D}/usr/bin:" \
		-e "s:/usr/local/etc:${D}/etc/logcheck:" \
		${S}/Makefile || die
	make CFLAGS="${CFLAGS}" linux || die

	dodoc README* CHANGES LICENSE CREDITS
	dodoc systems/linux/README.*

	cat << EOF > ${D}/etc/cron.hourly/logsentry.cron
#!/bin/sh
#
# Uncomment the following if you want 
# logsentry (logcheck) to run hourly
#
# this is part of the logsentry package
#
#

#/bin/sh /etc/logcheck/logcheck.sh
EOF

}

pkg_postinst() {
	einfo 
	einfo "uncomment the logwatch line in /etc/cron.hourly/logsentry.cron,"
	einfo "or add directly to root's crontab"
	einfo
}
