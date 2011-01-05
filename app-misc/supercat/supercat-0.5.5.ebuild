# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/supercat/supercat-0.5.5.ebuild,v 1.7 2011/01/05 16:32:16 jlec Exp $

DESCRIPTION="A text file colorizer using powerful regular expressions"
HOMEPAGE="http://supercat.nosredna.net"
SRC_URI="http://supercat.nosredna.net/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc64 sparc x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"

	dodoc ChangeLog || die
}
