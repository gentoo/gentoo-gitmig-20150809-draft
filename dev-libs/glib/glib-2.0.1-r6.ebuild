# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.0.1-r6.ebuild,v 1.3 2002/07/24 03:44:56 cselkirk Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"



S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.gtk.org/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc"
SLOT="2"

DEPEND="virtual/glibc
		>=dev-util/pkgconfig-0.12.0
		doc? ( >=dev-util/gtk-doc-0.9-r2 )"


# libiconv breaks other stuff

RDEPEND="virtual/glibc"

src_compile() {
# Running libtoolize results in missing .so files -- karltk 2002-05-25
#	libtoolize --copy --force
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
		    --with-threads=posix \
			${myconf} \
		    --enable-debug=yes || die

# This had to be removed since it broke other stuff. darn. 2002-05-03
#	--with-libiconv=gnu \

 
# you cannot disable debug or this will fail building.
# odd but true :/

	emake || die
}

src_install() {
	make prefix=${D}/usr \
	     infodir=${D}/usr/share/info \
	     mandir=${D}/usr/share/man \
	     install || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3 TODO.xml
}





