# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gconf/gst-plugins-gconf-0.10.2.ebuild,v 1.4 2006/04/08 12:00:37 dertobi123 Exp $

inherit gnome2 gst-plugins-good gst-plugins10

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=gnome-base/gconf-2.0"
GST_PLUGINS_BUILD="gconf gconftool"

# override eclass
src_unpack() {

	local makefiles

	unpack ${A}

}

src_compile() {

	gst-plugins-good_src_configure ${@}

	gst-plugins10_find_plugin_dir
	emake || die "compile failure"

	cd ${S}/gconf
	emake || die "compile failure"

}
src_install() {

	gst-plugins10_find_plugin_dir
	einstall || die

	cd ${S}/gconf
	gnome2_src_install || die
}
