# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.8.0.1.ebuild,v 1.6 2004/12/11 10:57:57 kloeri Exp $

inherit gnome2 eutils

DESCRIPTION="The GNOME panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc ~hppa ~amd64 ~ia64 ~mips ~ppc64 ~arm"
IUSE="doc eds"

RDEPEND=">=x11-libs/gtk+-2.3.2
	>=x11-libs/libwnck-2.7.91
	>=gnome-base/orbit-2.4
	>=gnome-base/gnome-vfs-2.3
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libglade-2.3
	>=gnome-base/libgnome-2.1.1
	>=gnome-base/libgnomeui-2.5.4
	>=gnome-base/gconf-2.6.1
	media-libs/libpng
	eds? ( >=gnome-extra/evolution-data-server-0.0.97 )
	!gnome-extra/system-tray-applet"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.31
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README"

src_compile() {

	gnome2_src_configure

	# FIXME : uh yeah, this is nice
	# We should patch in a switch here and send it upstream
	sed -i 's:--load:-v:' gnome-panel/Makefile || die

	emake || die

}

G2CONF="${G2CONF} $(use_enable eds)"

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "setting panel gconf defaults..."
	GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source`
	${ROOT}/usr/bin/gconftool-2 --direct --config-source ${GCONF_CONFIG_SOURCE} --load=/etc/gconf/schemas/panel-default-setup.entries
	rm /etc/gconf/schemas/panel-default-setup.entries

}
