# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-2.6.2.ebuild,v 1.3 2004/07/31 03:52:17 spider Exp $

inherit gnome2 eutils

DESCRIPTION="Applets for the Gnome2 Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"

IUSE="doc apm acpi ipv6 gstreamer"
SLOT="2"
LICENSE="GPL-2 FDL-1.1"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ppc64"

RDEPEND=">=x11-libs/gtk+-2.1
	>=gnome-base/gail-1.3
	>=gnome-base/gconf-2.0
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgtop-2.5
	>=gnome-base/gnome-panel-2.5
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=x11-libs/libxklavier-0.97
	apm? ( sys-apps/apmd )
	acpi? ( sys-apps/acpid )
	gstreamer? ( >=media-libs/gstreamer-0.8 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog COPYING COPYING-DOCS INSTALL NEWS README"

G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable gstreamer) --enable-flags"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix
	cd ${S}
}

src_install () {

	gnome2_src_install

	for BLERHG  in accessx-status battstat cdplayer charpick drivemount geyes gkb-new gtik gweather mailcheck mini-commander mixer modemlights multiload screen-exec stickynotes wireless; do
			docinto ${BLERHG}
			dodoc ${BLERHG}/[ChangeLog,AUTHORS,NEWS,TODO] ${BLERHG}/README*
	done

}

USE_DESTDIR="1"
