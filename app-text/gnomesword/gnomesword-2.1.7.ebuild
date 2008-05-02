# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnomesword/gnomesword-2.1.7.ebuild,v 1.9 2008/05/02 15:02:37 cardoe Exp $

inherit libtool gnome2 eutils

DESCRIPTION="Gnome Bible study software"
HOMEPAGE="http://gnomesword.sf.net/"
SRC_URI="mirror://sourceforge/gnomesword/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE="spell"

RDEPEND="=gnome-extra/gtkhtml-3*
	=app-text/sword-1.5.8*
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	dev-libs/libxml2
	virtual/libc
	spell? ( app-text/gnome-spell
	>=gnome-base/libbonoboui-2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.14"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable spell pspell)"
	DOCS="NEWS ChangeLog README TODO"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-commentary_dialog.c.patch"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "Gnomesword requires modules to be of any use. You may install the"
	elog "sword-modules package, or download modules individually from the"
	elog "sword website: http://crosswire.org/sword/"
}
