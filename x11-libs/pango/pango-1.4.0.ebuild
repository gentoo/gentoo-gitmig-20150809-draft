# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.4.0.ebuild,v 1.13 2004/07/24 01:32:31 tgall Exp $

inherit gnome2 eutils

DESCRIPTION="Text rendering and layout library"
HOMEPAGE="http://www.pango.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.4/${P}.tar.bz2"

LICENSE="LGPL-2 FTL"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ~ia64 ppc64"
IUSE="doc"

RDEPEND="virtual/x11
	virtual/xft
	>=dev-libs/glib-2.4
	>=media-libs/fontconfig-1.0.1
	>=media-libs/freetype-2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Some enhancements from Redhat
	epatch ${FILESDIR}/pango-1.0.99.020606-xfonts.patch
	epatch ${FILESDIR}/${PN}-1.2.2-slighthint.patch
}

DOCS="AUTHORS ChangeLog README INSTALL NEWS TODO*"

src_install() {
	gnome2_src_install
	rm ${D}/etc/pango/pango.modules
}

pkg_postinst() {
	einfo "Generating modules listing..."
	pango-querymodules > /etc/pango/pango.modules
}
