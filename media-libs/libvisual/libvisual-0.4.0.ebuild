# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvisual/libvisual-0.4.0.ebuild,v 1.6 2006/10/20 12:29:07 blubb Exp $

inherit eutils

DESCRIPTION="Libvisual is an abstraction library that comes between applications and audio visualisation plugins."
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0.4"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_compile() {
	econf \
		--enable-shared \
		--enable-static \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
