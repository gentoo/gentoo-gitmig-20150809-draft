# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/portsentry/portsentry-1.2.ebuild,v 1.5 2004/07/06 03:10:06 malc Exp $

inherit eutils

DESCRIPTION="Automated port scan detector and response tool"
# Seems like CISCO took the site down?
HOMEPAGE="http://sourceforge.net/projects/sentrytools/"
SRC_URI="mirror://sourceforge/sentrytools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND=">=sys-apps/sed-4"
S=${WORKDIR}/${PN}_beta

src_unpack() {
	unpack ${A} ; cd ${S}

	# Setting the portsentry.conf file location
	sed -i \
		-e 's:/usr/local/psionic/portsentry/portsentry.conf:/etc/portsentry/portsentry.conf:' \
		portsentry_config.h || die "sed portsentry_config.h failed"

	# presetting the other file locations in portsentry.conf
	sed -i \
		-e 's:\(^IGNORE_FILE\).*:\1="/etc/portsentry/portsentry.ignore":g' \
	    -e 's:^\(HISTORY_FILE\).*:\1="/etc/portsentry/portsentry.history":g' \
	    -e 's:^\(BLOCKED_FILE\).*:\1="/etc/portsentry/portsentry.blocked":g' \
		portsentry.conf || die "sed portsentry.conf failed"

	sed -i \
		-e "s:^set SENTRYDIR.*:set SENTRYDIR=/etc/portsentry:g" \
		ignore.csh || die "sed ignore.csh failed"
	epatch ${FILESDIR}/gcc.patch
}

src_compile() {
	make CFLAGS="${CFLAGS}" linux || die
}

src_install() {
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
