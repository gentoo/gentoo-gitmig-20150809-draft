# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.2.2.ebuild,v 1.1 2003/06/02 22:19:25 foser Exp $

inherit gnome2 eutils

IUSE="doc"
SLOT="1"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DESCRIPTION="Text rendering and Layout library"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"
HOMEPAGE="http://www.pango.org/"
LICENSE="LGPL-2.1"

RDEPEND="virtual/x11
	virtual/xft
	>=dev-libs/glib-2.1.3
	>=media-libs/fontconfig-2
	>=media-libs/freetype-2.1.2-r2"
	
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.10 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Some enhancements from Redhat
	epatch ${FILESDIR}/pango-1.0.99.020606-xfonts.patch
	epatch ${FILESDIR}/${P}-slighthint.patch
}

G2CONF="${G2CONF} --without-qt "
DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO*"

src_install() {
	gnome2_src_install
	rm ${D}/etc/pango/pango.modules
}

pkg_postinst() {
	einfo "Generating modules listing..."
	pango-querymodules > /etc/pango/pango.modules
}
