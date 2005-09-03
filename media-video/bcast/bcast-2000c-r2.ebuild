# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bcast/bcast-2000c-r2.ebuild,v 1.13 2005/09/03 23:28:16 flameeyes Exp $

inherit eutils

DESCRIPTION="Realtime audio and video editor"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.gz"
HOMEPAGE="http://heroines.sourceforge.net/"

DEPEND="dev-lang/nasm
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.2.1
	virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	cd ${S}
	epatch ${FILESDIR}/bcast-2000c-gcc3-gentoo.patch
}

src_compile() {
	./configure || die
	make || die
}

src_install () {
	into /usr
	dobin bcast/bcast2000
	dolib.so bcbase/libbcbase.so
	dolib.so guicast/libguicast.so
	insopts -m 755
	insinto /usr/lib/bcast/plugins
	doins plugins/*.plugin
	dohtml -r docs
}
