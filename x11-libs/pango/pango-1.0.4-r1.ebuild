# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.0.4-r1.ebuild,v 1.4 2002/08/14 13:05:59 murphy Exp $

inherit libtool

SLOT="1"
KEYWORDS="x86 ppc sparc sparc64"

S=${WORKDIR}/${P}
DESCRIPTION="Text rendering and Layout library"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.pango.org/"
LICENSE="LGPL-2.1"

RDEPEND="virtual/x11
	>=dev-libs/glib-2.0.6-r1
	>=media-libs/freetype-2.1.2"
	
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"


src_compile() {
	elibtoolize
	local myconf
	use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	if [ -n "$DEBUG" ]; then
		myconf="${myconf}  --enable-debug"
	fi
				
	
	econf ${myconf} --without-qt  || die
	make || die "serial make failed" 
}

src_install() {
	einstall
	rm ${D}/etc/pango/pango.modules


 	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3 TODO*
}

pkg_postinst() {
	pango-querymodules >/etc/pango/pango.modules
}

