# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.9.9-r1.ebuild,v 1.2 2002/05/02 20:38:33 seemant Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://xine.sourceforge.net/files/xine-ui-${PV}.tar.gz
	directfb? ( http://www.ibiblio.org/gentoo/distfiles/${PN}-gentoo-extra.tar.bz2 )"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="virtual/glibc
	media-libs/libpng
	>=media-libs/xine-lib-${PV}
	nls? ( sys-devel/gettext )
	X? ( virtual/x11 )
	directfb? ( >=dev-libs/DirectFB-0.9.9 )
	gnome? ( gnome-base/ORBit )"

SLOT="0"

src_unpack() {

	unpack ${P}.tar.gz

	# for some reason upstream skipped on including some files for the
	# DirectFB front-end for this.
	use directfb && ( \
		unpack ${PN}-gentoo-extra.tar.bz2
		mv ${WORKDIR}/dfb/* ${S}/src/dfb
	)
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
