# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-1.99.3.ebuild,v 1.1 2003/04/21 14:43:25 liquidx Exp $

IUSE="doc"

inherit gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/libgnomeprint-2.2.0
	>=gnome-base/libgnomeprintui-2.2.1
    >=gnome-base/libglade-2.0
    >=gnome-base/libgnomeui-2.0
    >=gnome-base/libgnomecanvas-2.0
    >=dev-libs/libxml2-2.0"
    
DEPEND="sys-devel/gettext
        doc? ( dev-util/gtk-doc )
        ${RDEPEND}"

src_compile() {
	elibtoolize

	local myconf=""

    if [ -n "`use doc`" ]; then
       myconf="${myconf} --enable-gtk-doc"
    else 
       myconf="${myconf} --disable-gtk-doc"
    fi

	econf ${myconf} || die
	make || die # parallel make doesn't work
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

