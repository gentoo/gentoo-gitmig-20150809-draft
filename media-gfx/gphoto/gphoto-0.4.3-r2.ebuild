# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto/gphoto-0.4.3-r2.ebuild,v 1.3 2002/07/23 04:33:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="http://www.gphoto.net/dist/${P}.tar.gz"
HOMEPAGE="http://www.gphoto.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-libs/imlib
	>=media-gfx/imagemagick-4.1"

src_unpack() {
	unpack ${A}
	cd ${S}/sony
	patch <${FILESDIR}/gphoto-0.4.3-sony-command.c-gentoo.patch
}

src_compile() {

	# -pipe does no work
	CFLAGS="${CFLAGS/-pipe}"
	./configure --prefix=/usr --sysconfdir=/etc/gnome || die
	make clean || die
	pmake || die
}

src_install() {
	 make prefix=${D}/usr sysconfdir=${D}/etc/gnome  install || die
	 dodoc AUTHORS CONTACTS COPYING ChangeLog FAQ MANUAL NEWS* PROGRAMMERS \
		 README THANKS THEMES TODO
}
