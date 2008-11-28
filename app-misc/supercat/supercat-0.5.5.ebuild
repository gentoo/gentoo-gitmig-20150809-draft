# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/supercat/supercat-0.5.5.ebuild,v 1.5 2008/11/28 20:22:11 tcunha Exp $

DESCRIPTION="A text file colorizer using powerful regular expressions"
HOMEPAGE="http://supercat.nosredna.net"
SRC_URI="http://supercat.nosredna.net/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""
src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"

	dodoc ChangeLog
}
