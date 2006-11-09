# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whoischk/whoischk-0.2.4-r1.ebuild,v 1.1 2006/11/09 15:24:29 kang Exp $

DESCRIPTION="monitor a list of domains and report when there has been any change"
HOMEPAGE="http://downloads.afterdark.org.uk/whoischk/"
SRC_URI="http://downloads.afterdark.org.uk/whoischk/${P}.tar.gz"

inherit eutils

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~x86"
IUSE=""

RDEPEND="app-shells/bash
	net-misc/jwhois"

src_compile() {
	sed -i -e 's|WHOIS=whois|WHOIS="jwhois\ -f"|' whoischk || die
	epatch ${FILESDIR}/throttle.patch.bz2
}

src_install() {
	dobin whoischk || die
	dodoc AUTHOR ChangeLog INSTALL LICENCE PATCHES README USAGE sample-rc-file
}
