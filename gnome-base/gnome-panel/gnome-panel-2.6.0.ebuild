# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.6.0.ebuild,v 1.1 2004/03/22 23:37:34 foser Exp $

inherit gnome2 eutils

DESCRIPTION="The Panel for Gnome2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 FDL-1.1 LGPL-2"

IUSE="doc"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2.3.2
	>=x11-libs/libwnck-2.3
	>=gnome-base/ORBit2-2.4
	>=gnome-base/gnome-vfs-2.3
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libglade-2.3
	>=gnome-base/libgnome-2.1.1
	>=gnome-base/libgnomeui-2.5.4
	>=gnome-base/gconf-2.3.3
	media-libs/libpng
	!gnome-extra/system-tray-applet"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README"

src_unpack() {

	unpack ${A}
	cd ${S}

	# should fix parallel install #45315
	epatch ${FILESDIR}/${PN}-2.6-parallel_install.patch

}

src_compile() {

	gnome2_src_configure

	# FIXME : uh yeah, this is nice
	# We should patch in a switch here and send it upstream
	sed -i 's:--load:-v:' gnome-panel/Makefile || die

	emake || die

}

# hard disable eds support for now
G2CONF="${G2CONF} --disable-eds"

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "setting panel gconf defaults..."
	GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source`
	${ROOT}/usr/bin/gconftool-2 --direct --config-source ${GCONF_CONFIG_SOURCE} --load=/etc/gconf/schemas/panel-default-setup.entries

}
