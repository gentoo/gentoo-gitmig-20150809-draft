# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-0.24.ebuild,v 1.4 2003/05/16 01:02:46 pylon Exp $

IUSE="nls doc"

inherit gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/libxml-1.8.16
         >=gnome-base/gnome-print-0.34
         =gnome-base/libglade-0*
         =x11-libs/gtk+-1.2*
         <gnome-base/gnome-vfs-1.9.0
         >=dev-libs/libunicode-0.4-r1
	media-libs/gdk-pixbuf"         

DEPEND="nls? ( sys-devel/gettext )
        >=dev-util/intltool-0.11
        dev-lang/perl
        doc? ( dev-util/gtk-doc )
        ${RDEPEND}"
		
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sgml-1.patch
}

src_compile() {
	elibtoolize

	local myconf=""
	use nls || myconf="--disable-nls"

    if [ -n "`use doc`" ]; then
       myconf="${myconf} --enable-gtk-doc"
    else 
       myconf="${myconf} --disable-gtk-doc"
    fi

	./configure --host=${CHOST}	\
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		     ${myconf} || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib	\
	     install || die

	# Add some type of backward compat...
	local fullname="`eval basename \`readlink ${D}/usr/lib/libgal.so\``"
	dosym ${fullname##*/} /usr/lib/libgal.so.$((`echo ${PV} | cut -d. -f2`-1))
	
	# gal-0.23 provides libgal.so.21, and its compatible with 0.24
	# so we add this symlink for more backwards compatibility - liquidx.
	dosym ${fullname##*/} /usr/lib/libgal.so.21
	
	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	einfo "If you upgraded gal, you must emerge gtkhtml again to prevent breakage."
}
