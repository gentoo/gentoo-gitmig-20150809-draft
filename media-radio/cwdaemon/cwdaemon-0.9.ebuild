# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/cwdaemon/cwdaemon-0.9.ebuild,v 1.1 2004/12/08 23:05:22 killsoft Exp $

DESCRIPTION="A morse daemon for the parallel or serial port"
HOMEPAGE="http://www.qsl.net/pg4i/linux/cwdaemon.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="sys-apps/gawk"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"
}
