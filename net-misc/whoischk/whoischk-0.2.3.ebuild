# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whoischk/whoischk-0.2.3.ebuild,v 1.3 2004/07/14 06:38:23 mr_bones_ Exp $

DESCRIPTION="monitor a list of domains and report when there has been any change"
HOMEPAGE="http://downloads.afterdark.org.uk/whoischk/"
SRC_URI="http://downloads.afterdark.org.uk/whoischk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

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
