# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/ccxstream/ccxstream-1.0.15.ebuild,v 1.3 2004/10/03 21:45:01 swegener Exp $

inherit eutils

DESCRIPTION="XStream Server"
HOMEPAGE="http://xbplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/xbplayer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-libs/ncurses sys-libs/readline"

src_compile() {
	epatch ${FILESDIR}/ccxstream-termcap.patch
	emake || die
}

src_install() {
	# add startup and sample config
	exeinto /etc/init.d
	newexe ${FILESDIR}/ccxstream.initd ccxstream
	insinto /etc/conf.d
	newins ${FILESDIR}/ccxstream.confd ccxstream
	dobin ccxstream || die
}
