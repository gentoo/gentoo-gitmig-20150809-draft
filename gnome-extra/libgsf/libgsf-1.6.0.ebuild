# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.6.0.ebuild,v 1.13 2004/07/14 15:57:25 agriffis Exp $

inherit gnome2

IUSE="gnome doc"
DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc ppc alpha amd64 ia64"

RDEPEND=">=dev-libs/libxml2-2.4.16
	 >=dev-libs/glib-2
	 >=sys-libs/zlib-1.1.4
	 gnome? ( >=gnome-base/libbonobo-2
	  	>=gnome-base/gnome-vfs-2 )"

DEPEND=">=dev-util/pkgconfig-0.9
	doc?	( dev-util/gtk-doc )"

src_unpack() {
	unpack ${A}
	cd ${S}/doc/

	# little hack to fix bug 7570
	cp Makefile.in Makefile.in.orig
	sed -e "s:doc\$(TARGET_DIR):\$(TARGET_DIR):" \
		Makefile.in.orig > Makefile.in
}

src_compile() {
	local myconf

	use gnome \
		&& myconf="--with-gnome" \
		|| myconf="--without-gnome"

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"

	econf ${myconf} --with-zlib  || die
	emake || die
}

DOCS="dodoc AUTHORS COPYING* ChangeLog INSTALL NEWS README"
