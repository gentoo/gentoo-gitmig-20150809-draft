# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvisual/libvisual-0.2.0.ebuild,v 1.11 2007/02/07 14:46:54 flameeyes Exp $

inherit eutils flag-o-matic

DESCRIPTION="Libvisual is an abstraction library that comes between applications and audio visualisation plugins."
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-ppc.patch
	epatch ${FILESDIR}/${P}-movd.patch
}

src_compile() {
	# force MMX on x86 to fix compilation, see bug 146335
	use x86 && append-flags -mmmx
	econf --enable-static --enable-shared || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
