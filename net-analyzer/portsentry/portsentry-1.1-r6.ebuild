# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/portsentry/portsentry-1.1-r6.ebuild,v 1.4 2002/07/21 20:48:48 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Automated port scan detector and response tool"
HOMEPAGE="http://www.psionic.com/abacus/portsentry/"
SRC_URI="http://www.psionic.com/tools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A} ; cd ${S}

	# Setting the portsentry.conf file location
	sed -e 's:/usr/local/psionic/portsentry/portsentry.conf:/etc/portsentry/portsentry.conf:' \
	portsentry_config.h | cat > portsentry_config.h

	# presetting the other file locations in portsentry.conf
	sed -e 's:^IGNORE_FILE.*:IGNORE_FILE="/etc/portsentry/portsentry.ignore":g' \
	    -e 's:^HISTORY_FILE.*:HISTORY_FILE="/etc/portsentry/portsentry.history":g' \
	    -e 's:^BLOCKED_FILE.*:BLOCKED_FILE="/etc/portsentry/portsentry.blocked":g' \
	portsentry.conf | cat > portsentry.conf

	sed -e "s:^set SENTRYDIR.*:set SENTRYDIR=/etc/portsentry:g" \
	ignore.csh | cat > ignore.csh
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
