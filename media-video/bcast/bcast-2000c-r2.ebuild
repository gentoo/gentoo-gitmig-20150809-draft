# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bcast/bcast-2000c-r2.ebuild,v 1.10 2003/09/11 01:22:29 msterret Exp $

S=${WORKDIR}/${P}
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

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die
	cd ${S}
	patch -p1 <${FILESDIR}/bcast-2000c-gcc3-gentoo.patch || die
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
	dodoc COPYING
	dohtml -r docs
}
