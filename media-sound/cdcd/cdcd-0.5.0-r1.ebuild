# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.5.0-r1.ebuild,v 1.10 2004/07/01 07:55:30 eradicator Exp $

IUSE=""

DESCRIPTION="a simple yet powerful command line cd player"
SRC_URI="http://cdcd.undergrid.net/source_archive/${P}.tar.gz"
HOMEPAGE="http://cdcd.undergrid.net/"
DEPEND="virtual/libc
	>=sys-libs/ncurses-5.0
	>=sys-libs/readline-4.0
	>=media-libs/libcdaudio-0.99.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	patch < ${FILESDIR}/${P}-r1-gentoo.patch

}

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
