# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.0.1-r3.ebuild,v 1.1 2002/05/09 23:04:17 spider Exp $

SLOT="1"

S=${WORKDIR}/${P}
DESCRIPTION="Text rendering and Layout library"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.pango.org/"


RDEPEND="virtual/x11
	>=dev-libs/glib-2.0.1
	>=media-libs/freetype-2.0.8"
	
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"


src_compile() {
	libtoolize --copy --force
	local myconf
	use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
			${myconf} \
		    --enable-debug || die
# turn on debug again, glib dislikes not having it.
	emake || make || die "paralell make and serial make failed" 
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	rm ${D}/etc/pango/pango.modules


 	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3 TODO*
}

pkg_postinst() {
	pango-querymodules >/etc/pango/pango.modules
}

