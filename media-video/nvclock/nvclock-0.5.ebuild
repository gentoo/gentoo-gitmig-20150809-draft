# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.4.2.ebuild,v 1.3 2002/05/23 06:50:14 seemant Exp

S=${WORKDIR}/${PN}${PV}
SRC_URI="http://www.evil3d.net/download/${PN}/${PN}${PV}.tar.gz"
DESCRIPTION="NVIDIA overclocking utility"
HOMEPAGE="http://www.evil3d.net/products/nvclock/"

RDEPEND="virtual/glibc
	gtk? ( virtual/x11 =x11-libs/gtk+-1.2* )
	qt? ( virtual/x11 x11-libs/qt )"
DEPEND="$RDEPEND sys-devel/autoconf"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	local myconf
	use gtk && myconf="--enable-gtk"
	use qt && myconf="${myconf} --enable-qt"
	autoconf
	econf ${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D} install	
	dodoc AUTHORS COPYING README	
}
