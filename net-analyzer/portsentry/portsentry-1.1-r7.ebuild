# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/portsentry/portsentry-1.1-r7.ebuild,v 1.5 2003/04/23 00:02:57 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Automated port scan detector and response tool"
HOMEPAGE="http://www.psionic.com/abacus/portsentry/"
SRC_URI="http://www.psionic.com/tools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=sys-apps/sed-4*"

src_unpack() {

	unpack ${A} ; cd ${S}

	# Setting the portsentry.conf file location
	sed -i -e 's:/usr/local/psionic/portsentry/portsentry.conf:/etc/portsentry/portsentry.conf:' \
		portsentry_config.h

	# presetting the other file locations in portsentry.conf
	sed -i -e 's:\(^IGNORE_FILE\).*:\1="/etc/portsentry/portsentry.ignore":g' \
	    -e 's:^\(HISTORY_FILE\).*:\1="/etc/portsentry/portsentry.history":g' \
	    -e 's:^\(BLOCKED_FILE\).*:\1="/etc/portsentry/portsentry.blocked":g' \
		portsentry.conf

	sed -i "s:^set SENTRYDIR.*:set SENTRYDIR=/etc/portsentry:g" \
		ignore.csh
}

src_compile() {

	make CFLAGS="${CFLAGS}" linux || die
}

src_install () {

	dobin portsentry ignore.csh
	dodoc README* CHANGES LICENSE CREDITS
	newdoc portsentry.ignore portsentry.ignore.sample
	newdoc portsentry.conf portsentry.conf.sample

	insinto /etc/portsentry
	newins portsentry.ignore portsentry.ignore.sample
	newins portsentry.conf portsentry.conf.sample

	exeinto /etc/init.d ; newexe ${FILESDIR}/portsentry.rc6 portsentry
	insinto /etc/conf.d ; newins ${FILESDIR}/portsentry.confd portsentry
}
