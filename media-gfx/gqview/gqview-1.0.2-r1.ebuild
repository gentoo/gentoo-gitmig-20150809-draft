# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-1.0.2-r1.ebuild,v 1.3 2002/07/11 06:30:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GNOME image browser"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"
HOMEPAGE="http://gqview.sourceforge.net/"

DEPEND="media-libs/libpng
	>=media-libs/gdk-pixbuf-0.16.0-r4
	=x11-libs/gtk+-1.2*"
	
RDEPEND="nls? ( sys-devel/gettext )"


src_compile() {

	local myconf
	
	use nls || myconf="--disable-nls"

	./configure --prefix=/usr				\
		--mandir=/usr/share/man				\
		--infodir=/usr/share/info			\
		--sysconfdir=/etc				\
		--host=${CHOST}					\
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr					\
		mandir=${D}/usr/share/man			\
		infodir=${D}/usr/share/info			\
		sysconfdir=${D}/etc				\
		GNOME_DATADIR=${D}/usr/share			\
		install || die
	
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
