# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/soup/soup-0.7.4.ebuild,v 1.1 2002/09/28 07:55:14 azarah Exp $

inherit gnome.org libtool

S=${WORKDIR}/${P}
DESCRIPTION="Soup is a SOAP implementation"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=dev-util/pkgconfig-0.12.0
	=dev-libs/glib-1.2*
	>=dev-libs/libxml2-2.4.16
	dev-libs/popt
	ssl? ( dev-libs/openssl )
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

LICENSE="GPL-2 | LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	elibtoolize

	local myconf=""
	use ssl \
		&&  myconf="--enable-ssl" \
		||  myconf="--disable-ssl"

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"

	# there is a --enable-apache here.....

	econf \
		${myconf} \
		--with-libxml=2 || die

	emake || die
}

src_install() {
	einstall || die
    
 	dodoc AUTHORS ABOUT-NLS COPYING* ChangeLog README* INSTALL NEWS TODO
}

