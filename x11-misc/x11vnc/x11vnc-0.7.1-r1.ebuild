# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x11vnc/x11vnc-0.7.1-r1.ebuild,v 1.3 2005/05/25 04:31:29 vapier Exp $

inherit eutils

DESCRIPTION="A VNC server for real X displays"
HOMEPAGE="http://www.karlrunge.com/x11vnc/"
SRC_URI="mirror://sourceforge/libvncserver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"
IUSE="jpeg zlib"

DEPEND="virtual/x11
	zlib? ( sys-libs/zlib )
	jpeg? (
		media-libs/jpeg
		sys-libs/zlib
	)"

src_compile() {
	local myconf=""
	use jpeg && myconf="${myconf} --enable-zlib"

	econf \
		$(use_with jpeg) \
		$(use_with zlib) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc x11vnc/{ChangeLog,README}
}
