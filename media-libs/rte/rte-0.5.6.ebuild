# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/rte/rte-0.5.6.ebuild,v 1.2 2005/08/29 23:55:05 vanquirius Exp $

inherit eutils

IUSE="esd alsa divx4linux"

DESCRIPTION="Real Time Encoder"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

DEPEND="esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )
	divx4linux? ( media-libs/divx4linux )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -sparc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-config.patch
}

src_compile() {
	econf `use_with divx4linux` || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
