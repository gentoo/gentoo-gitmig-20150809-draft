# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whoischk/whoischk-0.2.4.ebuild,v 1.4 2005/03/10 22:58:45 vapier Exp $

DESCRIPTION="monitor a list of domains and report when there has been any change"
HOMEPAGE="http://downloads.afterdark.org.uk/whoischk/"
SRC_URI="http://downloads.afterdark.org.uk/whoischk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 x86"
IUSE=""

RDEPEND="app-shells/bash
	net-misc/jwhois"

src_compile() {
	sed -i -e 's|WHOIS=whois|WHOIS=jwhois|' whoischk || die
}

src_install() {
	dobin whoischk || die
	dodoc AUTHOR ChangeLog INSTALL LICENCE PATCHES README USAGE sample-rc-file
}
