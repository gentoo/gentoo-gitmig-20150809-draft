# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/umix/umix-1.0.2.ebuild,v 1.6 2004/10/20 05:38:52 eradicator Exp $

IUSE="ncurses oss"

DESCRIPTION="Program for adjusting soundcard volumes"
HOMEPAGE="http://umix.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 sparc x86 sparc"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )"

src_compile() {
	local myconf
	use ncurses || myconf="--disable-ncurses"
	use oss || myconf="${myconf} --disable-oss"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README TODO
}
