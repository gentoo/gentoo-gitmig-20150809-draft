# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.9.11.ebuild,v 1.3 2002/07/16 11:36:53 seemant Exp $ 

DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
HOMEPAGE="http://xine.sourceforge.net/"
LICENSE="GPL"

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-${PV}
	X? ( virtual/x11 )
	aalib? ( media-libs/aalib )
	gnome? ( gnome-base/ORBit )
	directfb? ( >=dev-libs/DirectFB-0.9.9 )"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

SRC_URI="http://xine.sourceforge.net/files/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}
	cd ${S}

	use directfb || ( \
		sed -e "s:dfb::" src/Makefile.in \
		    > src/Makefile.in.hacked
		mv src/Makefile.in.hacked src/Makefile.in
	)

	sed -e "s:LDFLAGS =:LDFLAGS = -L/lib:" src/xitk/Makefile.in \
	    > src/xitk/Makefile.in.hacked
	mv src/xitk/Makefile.in.hacked src/xitk/Makefile.in

}

src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use nls    || myconf="${myconf} --disable-nls"
  
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		${myconf} || die

	emake || die
}

src_install() {
	
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
