# Copyright 1999-2003 Gentoo Technologies, Inc., 2003 acid DOT punk AT gmx DOT net
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vcp/vcp-1.6.2.ebuild,v 1.2 2003/09/05 12:10:36 msterret Exp $

inherit flag-o-matic
filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE

DESCRIPTION="copy files/directories in a curses interface"
HOMEPAGE="http://members.optusnet.com.au/~dbbryan/vcp/"
SRC_URI="http://members.optusnet.com.au/~dbbryan/vcp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-libs/ncurses"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin vcp
	doman vcp.1
	insinto /etc
	newins vcp.conf.sample vcp.conf
}
