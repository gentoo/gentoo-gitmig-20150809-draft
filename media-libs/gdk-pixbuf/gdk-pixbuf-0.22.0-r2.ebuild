# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.22.0-r2.ebuild,v 1.7 2004/03/23 17:09:51 avenj Exp $

inherit virtualx libtool gnome.org gnuconfig

IUSE="doc mmx"
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
HOMEPAGE="http://www.gtk.org/"

RDEPEND="media-libs/jpeg
	media-libs/tiff
	=x11-libs/gtk+-1.2*
	>=media-libs/libpng-1.2.1
	amd64? ( sys-libs/db )
	!amd64? ( <sys-libs/db-2 )
	>=gnome-base/gnome-libs-1.4.1.2-r1"
# We need gnome-libs here, else gnome support do not get compiled into
# gdk-pixbuf (the GnomeCanvasPixbuf library )

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~ppc sparc ~alpha ~hppa amd64 ia64 ~mips"

src_compile() {
	#allow to build on mipslinux systems
	use mips && gnuconfig_update

	local myconf
	#update libtool, else we get the "relink bug"
	elibtoolize

	use doc && myconf="--enable-gtk-doc" \
		|| myconf="--disable-gtk-doc"
	use mmx || myconf="${myconf} --disable-mmx"
	econf --sysconfdir=/etc/X11/gdk-pixbuf ${myconf}  || die

	#build needs to be able to
	#connect to an X display.
	Xemake || die
}

src_install() {
	einstall \
		sysconfdir=${D}/etc/X11/gdk-pixbuf || die

	dosed -e "s:${D}::g" /usr/bin/gdk-pixbuf-config
	#fix permissions on the loaders
	chmod a+rx ${D}/usr/lib/gdk-pixbuf/loaders
	chmod a+r ${D}/usr/lib/gdk-pixbuf/loaders/*

	dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}
