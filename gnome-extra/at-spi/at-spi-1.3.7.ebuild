# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.3.7.ebuild,v 1.1 2003/09/11 21:40:54 spider Exp $

IUSE="doc"

inherit gnome2

DESCRIPTION="This is the Gnome Accessibility Toolkit"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~alpha ~amd64"

RDEPEND=">=gnome-base/gail-1.3
	>=gnome-base/libbonobo-2.0.0
	>=dev-libs/atk-1.4
	>=x11-libs/gtk+-2
	>=dev-libs/popt-1.6.3
	>=gnome-base/ORBit2-2
	virtual/x11"
# virtual/x11 for libXtst libXi libXkb

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( dev-util/gtk-doc )"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"

src_unpack() {
	unpack ${A}
	#epatch ${FILESDIR}/${P}-lspi.patch
}
