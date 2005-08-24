# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.11.92.ebuild,v 1.1 2005/08/24 06:21:40 leonardop Exp $

inherit gnome2

DESCRIPTION="The GNOME panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc eds static"

RDEPEND=">=gnome-base/gnome-desktop-2.9.91
	>=x11-libs/gtk+-2.7.1
	>=gnome-base/libglade-2.5
	>=gnome-base/libgnome-2.1.1
	>=gnome-base/libgnomeui-2.5.4
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/orbit-2.4
	>=gnome-base/gnome-vfs-2.9.1
	>=x11-libs/libwnck-2.9.92
	>=gnome-base/gconf-2.6.1
	>=gnome-base/gnome-menus-2.11.1
	>=gnome-base/libbonobo-2
	media-libs/libpng
	eds? ( >=gnome-extra/evolution-data-server-0.0.97 )
	!gnome-extra/system-tray-applet"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.31
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING NEWS README"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable eds) $(use_enable static) --disable-scrollkeeper"
}

src_unpack() {
	unpack "${A}"

	# FIXME : uh yeah, this is nice
	# We should patch in a switch here and send it upstream
	sed -i 's:--load:-v:' ${S}/gnome-panel/Makefile.in || die "sed failed"
}

pkg_postinst() {

	local entries="/etc/gconf/schemas/panel-default-setup.entries"
	if [ -e "$entries" ]; then
		einfo "setting panel gconf defaults..."
		GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source`
		${ROOT}/usr/bin/gconftool-2 --direct --config-source \
			${GCONF_CONFIG_SOURCE} --load=${entries}
		rm -f ${entries}
	fi

	# Calling this late so it doesn't process the GConf schemas file we already
	# took care of.
	gnome2_pkg_postinst

}

