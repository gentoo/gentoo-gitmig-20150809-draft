# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.2.1.ebuild,v 1.10 2003/07/08 20:11:14 liquidx Exp $

inherit libtool

IUSE="doc"
S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"
HOMEPAGE="http://www.gtk.org/"

SLOT="2"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha arm hppa mips"

DEPEND=">=dev-util/pkgconfig-0.14.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

RDEPEND="virtual/glibc"

src_compile() {
	# Seems libtool have another wierd bug, try to fix it
	# with a fix for nautilus, bug #4190
	elibtoolize --reverse-deps
	
	local myconf=""
	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"

	if [ -n "$DEBUGBUILD" -o -n "`use debug`" ]; then
		myconf="${myconf}  --enable-debug=yes"
    	fi

	econf \
		--with-threads=posix \
		${myconf} || die

	emake || die
}

src_install() {
	einstall || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3
}
