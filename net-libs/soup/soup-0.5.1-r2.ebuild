# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/soup/soup-0.5.1-r2.ebuild,v 1.5 2002/07/23 06:52:41 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Soup is a SOAP implementation"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/unstable/sources/soup/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=dev-util/pkgconfig-0.12.0
	=dev-libs/glib-1.2*
	>=dev-libs/libxml2-2.4.16
	dev-libs/popt
	ssl? ( dev-libs/openssl )
	perl? ( >=dev-util/gtk-doc-0.9-r2 )"

SLOT="0"
LICENSE="GPL-2 | LGPL-2"
KEYWORDS="x86"

src_compile() {
	local myconf
	use ssl \
		&&  myconf="--enable-ssl" \
		||  myconf="--disable-ssl"

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"
	# there is a --enable-apache here.....
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
	CXXFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"

	econf \
		${myconf} \
		--with-libxml=2 || die

	emake || die
}

src_install() {
	einstall || die
    
 	dodoc AUTHORS  ABOUT-NLS COPYING* ChangeLog  README* INSTALL NEWS TODO 
}
