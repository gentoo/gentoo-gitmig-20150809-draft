# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Spider  <spider@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/glib/glib-1.3.14.ebuild,v 1.1 2002/02/20 22:11:06 gbevin Exp

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

src_compile() {
	local myconf
	use ssl &&  myconf="--enable-ssl" ||  myconf="--disable-ssl"
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	# there is a --enable-apache here.....
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
	CXXFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"
	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
			--with-libxml=2 \
			${myconf} \
			--infodir=/usr/share/info \
		    --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
 	dodoc AUTHORS  ABOUT-NLS COPYING* ChangeLog  README* INSTALL NEWS TODO 
}





