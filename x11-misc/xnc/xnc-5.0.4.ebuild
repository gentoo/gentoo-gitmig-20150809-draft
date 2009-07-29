# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnc/xnc-5.0.4.ebuild,v 1.12 2009/07/29 10:49:33 flameeyes Exp $

DESCRIPTION="file manager for X Window system very similar to Norton Commander"
HOMEPAGE="http://xnc.dubna.su/"
SRC_URI="http://xnc.dubna.su/src-5/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	media-libs/libpng
	media-libs/tiff
	media-libs/jpeg"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_enable nls` \
		|| die "./configure failed"
	emake || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog LICENSE README TODO
}
