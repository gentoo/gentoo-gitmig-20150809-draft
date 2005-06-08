# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lsdvd/lsdvd-0.15.ebuild,v 1.1 2005/06/08 14:12:15 luckyduck Exp $

DESCRIPTION="Utility for getting info out of DVDs"
HOMEPAGE="http://acidrip.sourceforge.net"
SRC_URI="mirror://sourceforge/acidrip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64 ~sparc"
IUSE=""

DEPEND="=media-libs/libdvdread-0.9*"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README
}
