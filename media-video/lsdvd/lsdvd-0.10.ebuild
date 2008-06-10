# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lsdvd/lsdvd-0.10.ebuild,v 1.11 2008/06/10 14:06:57 beandog Exp $

DESCRIPTION="Utility for getting info out of DVDs"
HOMEPAGE="http://untrepid.com/lsdvd/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 amd64 ~sparc"
IUSE=""

DEPEND="=media-libs/libdvdread-0.9*"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README
}
