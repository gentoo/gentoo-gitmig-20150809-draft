# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/portsentry/portsentry-1.1.ebuild,v 1.2 2001/09/13 00:09:53 lamer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="This is a sample skeleton ebuild file"
SRC_URI="http://www.psionic.com/tools/${P}.tar.gz"
HOMEPAGE="http://www.psionic.com/abacus/portsentry/"


src_unpack() {
	unpack ${A}
	cd ${S}

# Setting the portsentry.conf file location
	cat portsentry_config.h | \
	sed -e 's:^#define CONFIG_FILE "/usr/local/psionic/portsentry/portsentry.conf":#define CONFIG_FILE "/etc/portsentry/portsentry.conf":g' > portsentry_config.h

# presetting the other file locations in portsentry.conf
 cat portsentry.conf | sed -e \
	's:^IGNORE_FILE.*:IGNORE_FILE="/etc/portsentry/portsentry.ignore":g' -e \
	's:^HISTORY_FILE.*:HISTORY_FILE="/etc/portsentry/portsentry.history":g' -e \
	's:^BLOCKED_FILE.*:BLOCKED_FILE="/etc/portsentry/portsentry.blocked":g'   \
	> portsentry.conf 

	cat ignore.csh | sed -e "s:^set SENTRYDIR.*:set SENTRYDIR=/etc/portsentry:g" > ignore.csh

}

src_compile() {
	
	make linux || die
}

src_install () {

	exeinto /etc/init.d
	doexe ${FILESDIR}/portsentry
	dobin portsentry ignore.csh
	insinto /etc/portsentry
	doins portsentry.{ignore,conf}
	dodoc README* CHANGES LICENSE CREDITS 

}


pkg_postinst() {
	einfo "Please take a look at all the files in /etc/portsentry"
	einfo "as they need to be customized before you can run portsentry!"
	einfo "I can't stress enough to read the docs in /usr/share/doc/portsentry-1.1!"
	einfo "There is some changes you may make to the initscript to make the protection"
	einfo "more complete"
}
