# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot/gnome-pilot-2.0.13.ebuild,v 1.4 2006/05/02 18:33:53 liquidx Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Palm Pilot and Palm OS Device Syncing Library"
HOMEPAGE="http://live.gnome.org/GnomePilot"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/orbit-2.6.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/gconf-2.0
	>=dev-util/gob-2.0.5
	>=app-pda/pilot-link-0.11.7"

DEPEND="sys-devel/gettext
		>=dev-lang/perl-5.6.0
		${RDEPEND}"

G2CONF="${G2CONF} --enable-usb --enable-network --enable-pilotlinktest"

DOCS="AUTHORS COPYING* ChangeLog README NEWS"
SCROLLKEEPER_UPDATE="0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gnome2_omf_fix
}
