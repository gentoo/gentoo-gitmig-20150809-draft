# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/weex/weex-3.0.0_pre20030508.ebuild,v 1.1 2003/05/08 11:34:38 phosphan Exp $

S="${WORKDIR}/weex"

DESCRIPTION="Automates maintaining a web page or other FTP archive."
HOMEPAGE="http://sourceforge.net/projects/weex/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE="nls"

DEPEND="sys-libs/ncurses"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf}
	emake || die
}

src_install() {
	einstall || die
	dodoc doc/TODO
}
