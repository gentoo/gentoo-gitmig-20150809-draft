# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whoischk/whoischk-0.2.4.ebuild,v 1.1 2004/02/23 18:06:03 mholzer Exp $

DESCRIPTION="monitor a list of domains and report when there has been any change"
HOMEPAGE="http://downloads.afterdark.org.uk/whoischk/"
SRC_URI="http://downloads.afterdark.org.uk/whoischk/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}/${P}"

RDEPEND="app-shells/bash
	net-misc/jwhois"


src_compile() {
	sed -i -e 's|WHOIS=whois|WHOIS=jwhois|' whoischk || die
}

src_install() {
	dobin whoischk
	dodoc AUTHOR ChangeLog INSTALL LICENCE PATCHES README USAGE sample-rc-file
}
