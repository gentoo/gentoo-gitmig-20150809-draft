# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnomesword/gnomesword-2.2.3.ebuild,v 1.2 2007/12/13 22:35:30 eva Exp $

inherit libtool gnome2 eutils

DESCRIPTION="Gnome Bible study software"
HOMEPAGE="http://gnomesword.sf.net/"
SRC_URI="mirror://sourceforge/gnomesword/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="spell"
RDEPEND=">=gnome-extra/gtkhtml-3.14
	=app-text/sword-1.5.9*
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2
	dev-libs/libxml2
	virtual/libc
	spell? (
		app-text/gnome-spell
		>=gnome-base/libbonoboui-2 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.14"
G2CONF="${G2CONF} $(use_enable spell pspell)"
DOCS="NEWS ChangeLog README TODO"

pkg_postinst() {
	gnome2_pkg_postinst

	einfo "Gnomesword requires modules to be of any use. You may install the"
	einfo "sword-modules package, or download modules individually from the"
	einfo "sword website: http://crosswire.org/sword/"
}
