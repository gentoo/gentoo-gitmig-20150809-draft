# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpd/libmpd-0.01.ebuild,v 1.8 2006/02/12 02:16:52 metalgod Exp $

DESCRIPTION="A library handling connection to a MPD server."
HOMEPAGE="http://www.qballcow.nl/libmpd/"
SRC_URI="http://download.qballcow.nl/programs/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0.01"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""
DEPEND="virtual/libc
		sys-devel/libtool"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
}
