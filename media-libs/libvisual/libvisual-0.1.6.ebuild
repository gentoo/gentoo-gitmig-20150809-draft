# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvisual/libvisual-0.1.6.ebuild,v 1.6 2005/04/06 20:13:43 luckyduck Exp $

IUSE="pic static"

inherit eutils

DESCRIPTION="Libvisual is an abstraction library that comes between applications and audio visualisation plugins."

SRC_URI="mirror://sourceforge/libvisual/${P}.tar.gz"
HOMEPAGE="http://libvisual.sourceforge.net/"

LICENSE="LGPL-2.1 GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-libdir.patch
	epatch ${FILESDIR}/${P}-destdir.patch
}

src_compile() {
	local myconf=""

	use pic && myconf="${myconf} --with-pic"
	use static && myconf="${myconf} --enable-static"

	econf $myconf || die "configure failed"
	emake 		  || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
