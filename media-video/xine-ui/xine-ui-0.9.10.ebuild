# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.9.10.ebuild,v 1.1 2002/05/26 22:28:42 agenkin Exp $ 

DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="virtual/glibc
	media-libs/libpng
	>=media-libs/xine-lib-${PV}
	nls? ( sys-devel/gettext )
	X? ( virtual/x11 )
	directfb? ( >=dev-libs/DirectFB-0.9.9 )
	gnome? ( gnome-base/ORBit )"

SLOT="0"

SRC_URI="http://xine.sourceforge.net/files/xine-ui-${PV}.tar.gz"
S=${WORKDIR}/${P}

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
