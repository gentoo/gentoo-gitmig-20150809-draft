# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vcp/vcp-1.7.2.ebuild,v 1.1 2004/05/07 05:18:12 vapier Exp $

inherit flag-o-matic gcc

DESCRIPTION="copy files/directories in a curses interface"
HOMEPAGE="http://members.optusnet.com.au/~dbbryan/vcp/"
SRC_URI="http://members.optusnet.com.au/~dbbryan/vcp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	filter-lfs-flags
	emake CC="$(gcc-getCC)" || die "emake failed"
}

src_install() {
	dobin vcp || die
	doman vcp.1
	insinto /etc
	newins vcp.conf.sample vcp.conf
}
