# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.3.91.ebuild,v 1.2 2003/09/08 05:04:45 msterret Exp $

inherit gnome2 eutils

SLOT="0"

DESCRIPTION="The Panel for Gnome2"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

IUSE="doc"
MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND=">=x11-libs/gtk+-2.1
	>=x11-libs/libwnck-2.3
	>=gnome-base/ORBit2-2.4
	>=gnome-base/gnome-vfs-2.1.3
	>=gnome-base/gnome-desktop-2.3
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.1.1
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/gconf-2.3.1
	!gnome-extra/system-tray-applet"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	doc? ( >=dev-util/gtk-doc-0.9 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README"

src_compile() {

#	for i in $(find ${S}/help -iname Makefile.am); do
#		cp ${i} ${i}.old
#		sed -e 's:include \$(top_srcdir)/xmldocs.make::' ${i}.old > ${i}
#	done

#	cd ${S}/help/C/clock
#	mv Makefile.am Makefile.am.old
#	sed -e 's:include \$(top_srcdir)/xmldocs.make::' Makefile.am.old > Makefile.am
#	cd ${S}/help/C/window-list
#	mv Makefile.am Makefile.am.old
#	sed -e 's:include \$(top_srcdir)/xmldocs.make::' Makefile.am.old > Makefile.am
#	cd ${S}/help/C/workspace-switcher
#	mv Makefile.am Makefile.am.old
#	sed -e 's:include \$(top_srcdir)/xmldocs.make::' Makefile.am.old > Makefile.am


	cd ${S}

#	WANT_AUTOCONF_2_5=1 ./autogen.sh || die

	sed -i 's:--load:-v:' gnome-panel/Makefile.am

	WANT_AUTOMAKE=1.4 automake -v || die

	# FIXME : uh yeah, this is nice
	touch gnome-panel/blah
	chmod +x gnome-panel/blah

	gnome2_src_compile
}

pkg_postinst() {
	gnome2_pkg_postinst

	einfo "setting panel gconf defaults..."
	GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source` ${ROOT}/usr/bin/gconftool-2 --load=${S}/gnome-panel/panel-default-setup.entries
}
