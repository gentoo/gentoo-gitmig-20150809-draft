# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x11vnc/x11vnc-0.7.ebuild,v 1.5 2005/02/06 17:58:47 fserb Exp $

inherit eutils

DESCRIPTION="A VNC server for real X displays"
HOMEPAGE="http://www.karlrunge.com/x11vnc/"
SRC_URI="mirror://sourceforge/libvncserver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa x86 ~ppc"
IUSE="jpeg zlib"

RDEPEND="virtual/x11
	zlib? ( sys-libs/zlib )
	jpeg? (
		media-libs/jpeg
		sys-libs/zlib
	)"
DEPEND="${RDEPEND}
	net-libs/libvncserver
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/0.7-autotools.patch
	aclocal && automake && autoconf || die "autoconf failed"
}

src_compile() {
	econf \
		$(use_with jpeg) \
		$(use_with jpeg zlib) \
		$(use_with zlib) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc x11vnc/{ChangeLog,README}
}
