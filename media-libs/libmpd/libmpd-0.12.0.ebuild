# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpd/libmpd-0.12.0.ebuild,v 1.1 2006/03/27 06:34:09 ticho Exp $

DESCRIPTION="A library handling connection to a MPD server."
HOMEPAGE="http://www.qballcow.nl/libmpd/"
SRC_URI="http://download.qballcow.nl/programs/gmpc-0.13/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="virtual/libc
		sys-devel/libtool"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
}
