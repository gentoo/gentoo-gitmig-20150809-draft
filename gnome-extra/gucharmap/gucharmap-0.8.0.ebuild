# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-0.8.0.ebuild,v 1.2 2003/08/30 08:26:20 liquidx Exp $

inherit gnome2

DESCRIPTION="GNOME2 Unicode Character Map Display"
HOMEPAGE="http://gucharmap.sourceforge.net/"

RDEPEND=">=x11-libs/pango-1.2.1
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	gnome? ( >=gnome-base/libgnome-2
			>=gnome-base/libgnomeui-2 )
	!gnome? ( >=dev-libs/popt-1.5 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	>=dev-util/pkgconfig-0.9"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"

G2CONF="${G2CONF} `use_enable gnome` `use_enable cjk unihan`"

src_unpack() {
	unpack ${A}
	# do not re-generate gtk.immmodules during make install
	cd ${S}/gucharmap
	sed -i -e "s/\@BUILD_GTK_IMMODULES_TRUE\@.*LD_LIBRARY_PATH.*//" Makefile.in
}

src_install() {
	gnome2_src_install
	# disable installing symlinks otherwise it will conflict with gnome-utils-2.2*
	rm -f ${D}/usr/bin/gnome-character-map
}

pkg_postinst() {
	if [ -x "/usr/bin/gtk-query-immodules-2.0" ]; then
		einfo "Updating gtk.immodules configuration"
		gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
	fi		
}

pkg_postrm() {
	if [ -x "/usr/bin/gtk-query-immodules-2.0" ]; then
		einfo "Updating gtk.immodules configuration"	
		gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
	fi		
}
