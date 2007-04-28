# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/ccxstream/ccxstream-1.0.15.ebuild,v 1.7 2007/04/28 16:51:18 swegener Exp $

inherit eutils

DESCRIPTION="XStream Server"
HOMEPAGE="http://xbplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/xbplayer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="sys-libs/ncurses sys-libs/readline"
IUSE=""

src_compile() {
	epatch ${FILESDIR}/ccxstream-termcap.patch
	emake || die
}

src_install() {
	# add startup and sample config
	newinitd ${FILESDIR}/ccxstream.initd ccxstream
	newconfd ${FILESDIR}/ccxstream.confd ccxstream
	dobin ccxstream || die
}
