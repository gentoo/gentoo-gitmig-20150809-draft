# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/entity/entity-0.7.2.ebuild,v 1.14 2002/07/22 07:24:29 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An XML Framework"
SRC_URI="http://www.entity.cx/Download/files/${P}.tar.gz"
HOMEPAGE="http://www.entity.cx"

DEPEND=">=media-libs/imlib-1.9.10-r1
	>=dev-libs/libpcre-3.2
	tcltk? ( >=dev-lang/tk-8.1.1 )
	perl? ( >=sys-devel/perl-5.6 )
	python? ( >=dev-lang/python-2.0-r4 )
	sdl? ( >=media-libs/libsdl-1.1.7 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	opengl? ( <x11-libs/gtkglarea-1.99.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="MIT"
KEYWORD="x86"

src_compile() {

    local myconf
    if [ "`use tcltk`" ]
    then
        myconf="--enable-tcl=module --with-tcl=/usr/lib"
    else
        myconf="--enable-tcl=no"
    fi
    if [ "`use perl`" ]
    then
        myconf="$myconf --enable-perl=static"
    else
        myconf="$myconf --enable-perl=no"
    fi
    if [ "`use python`" ]
    then
	myconf="$myconf --enable-python=static"
    else
        myconf="$myconf --enable-python=no"
    fi
    if [ "`use ssl`" ]
    then
	myconf="$myconf --enable-openssl"
    fi
    if [ "`use sdl`" ]
    then
	myconf="$myconf --enable-sdl"
    fi
    if [ "`use gnome`" ]
    then
	myconf="$myconf --enable-gnome --enable-gdkimlib"
    fi
    if [ "`use opengl`" ]
    then
	myconf="$myconf --enable-gtkgl"
    fi
    try DEBIAN_ENTITY_MAGIC="voodoo" CFLAGS="$CFLAGS -I/usr/X11R6/include" ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	--enable-exec-class=yes \
	--enable-gtk=module \
	--enable-c=module $myconf \
	--enable-javascript=yes --with-included-njs --enable-csinc
    try make LDFLAGS="-L/usr/lib/python2.0/config/ -lpython2.0 `python-config --libs`"
}

src_install () {
    make DESTDIR=${D} LD_LIBRARY_PATH=${D}/usr/lib install
    insinto /usr/share/entity/stembuilder
    doins stembuilder/*.e
    chmod +x ${D}/usr/share/entity/stembuilder/stembuilder.e
    insinto /usr/share/entity/apps
    doins apps/*.e
    chmod +x ${D}/usr/share/entity/apps/{enview,ev}.e
    exeinto /usr/share/entity/examples
    doexe examples/*.e
    insinto /usr/share/entity/stembuilder/images
    doins stembuilder/images/*.xpm

    dodoc AUTHORS COPYING ChangeLog LICENSE NEWS README TODO 
    docinto txt
    dodoc docs/README* docs/*.txt docs/*.ascii
    docinto html
    dodoc docs/*.html
    docinto print
    dodoc docs/*.ps
    docinto sgml
    dodoc docs/*.sgml
}

