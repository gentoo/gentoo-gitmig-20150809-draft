# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnusim8085/gnusim8085-1.2.89.ebuild,v 1.1 2004/02/19 07:11:21 dragonheart Exp $
inherit eutils

DESCRIPTION="A GTK2 8085 Simulator"
HOMEPAGE="http://sourceforge.net/projects/gnusim8085"
SRC_URI="mirror://sourceforge/gnusim8085/GNUSim8085-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="nomirror"

IUSE="nls"
DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=gnome-base/libgnome-2.0
	>=gnome-base/libgnomecanvas-2.0
	>=media-libs/libart_lgpl-2.0
	>=gnome-base/gconf-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/ORBit2-2.0
	>=gnome-base/gnome-vfs-2.0
	>=dev-libs/libxml2-2.0
	>=x11-libs/pango-1.0
	>=dev-libs/popt-1.0
	>=dev-libs/atk-1.0
	>=media-libs/gdk-pixbuf-0.20
	>=gnome-base/libgnomeui-2.0"

DEPEND="${DEPEND}
	virtual/x11"

S=${WORKDIR}/GNUSim8085-${PV}

src_compile() {
	local myconf
	use nls  || myconf="--disable-nls"

	econf ${myconf} || die "Configuration failed"

	emake gnusim8085_LDADD='$(GNOME_LIBS)' || die "Make failed"
}

src_install() {
	einstall || die "Install Failed!"
	cd ${S}
	dodoc -r ABOUT-NLS COPYING INSTALL README doc/asm_reference.txt \
			doc/examples AUTHORS ChangeLog NEWS TODO
	doman doc/gnusim8085.1
	cd ${D}
	mv usr/doc/GNUSim8085/* ${D}/usr/share/doc/${P}
	rm -rf usr/doc
}

