# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whoischk/whoischk-0.2.3.ebuild,v 1.1 2003/08/17 13:38:38 mholzer Exp $

DESCRIPTION="monitor a list of domains and report when there has been any change"
HOMEPAGE="http://downloads.afterdark.org.uk/whoischk/"
SRC_URI="http://downloads.afterdark.org.uk/whoischk/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S="${WORKDIR}/${P}"

RDEPEND="app-shells/bash
	net-misc/jwhois"


src_compile() {
	for i in core/header.sh core/config.sh \
		functions/rcfile.sh functions/display.sh functions/whois.sh \
		handlers/com+net.sh handlers/org.sh handlers/uk-nominet.sh handlers/nz.sh handlers/other.sh \
		core/options.sh core/main.sh ; do

		cat ${i} >>whoischk
	done

	mv whoischk whoischk.orig
	sed <whoischk.orig >whoischk \
		-e 's|WHOIS=whois|WHOIS=jwhois|'
}

src_install() {
	dobin whoischk
	dodoc AUTHOR ChangeLog INSTALL LICENCE PATCHES README USAGE sample-rc-file
}
