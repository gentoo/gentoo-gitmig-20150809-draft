# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xiphos/xiphos-3.1.ebuild,v 1.3 2009/08/01 04:59:11 beandog Exp $

EAPI="2"

inherit libtool gnome2 eutils

DESCRIPTION="GTK+ based Bible study software, formerly gnomesword"
HOMEPAGE="http://xiphos.org"
SRC_URI="mirror://sourceforge/gnomesword/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="firefox seamonkey spell xulrunner +gtkhtml"
RDEPEND="
	=app-text/sword-1.6.0
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2
	app-text/gnome-doc-utils
	dev-libs/libxml2
	xulrunner? ( net-libs/xulrunner:1.8 )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )
	!xulrunner? ( !firefox? ( seamonkey? ( =www-client/seamonkey-1* ) ) )
	!xulrunner? ( !firefox? ( !seamonkey? ( gtkhtml? ( >=gnome-extra/gtkhtml-3.18 ) ) ) )
	spell? (
		app-text/gnome-spell
		>=gnome-base/libbonoboui-2 )"
DEPEND="${RDEPEND}
	!app-text/gnomesword
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.14"

pkg_setup() {
	if use xulrunner; then
		G2CONF="${G2CONF} --with-gecko=xulrunner"
	elif use firefox; then
		G2CONF="${G2CONF} --with-gecko=firefox"
	elif use seamonkey; then
		G2CONF="${G2CONF} --with-gecko=seamonkey"
	elif use gtkhtml; then
		G2CONF="${G2CONF} --enable-gtkhtml"
	else
		eerror "Setup your USE flags to specify a backend to use:"
		eerror "xulrunner, firefox, seamonkey or gtkhtml"
		die "Fix USE flags"
	fi
	G2CONF="${G2CONF} $(use_enable spell pspell)"
	DOCS="NEWS ChangeLog README TODO"

}

pkg_postinst() {
	gnome2_pkg_postinst

	einfo "Xiphos requires modules to be of any use. You may install the"
	einfo "sword modules packages in app-dicts/, or download modules"
	einfo "individually from the sword website: http://crosswire.org/sword/"
}
