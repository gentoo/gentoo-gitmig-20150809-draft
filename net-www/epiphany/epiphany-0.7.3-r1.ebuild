# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/epiphany/epiphany-0.7.3-r1.ebuild,v 1.1 2003/07/10 17:27:36 spider Exp $


# This fixes a paralell build problem that recently cropped up on my sytem
MAKEOPTS="-j1"
inherit gnome2 debug

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://epiphany.mozdev.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

G2CONF="${G2CONF} --with-mozilla-snapshot=1.4"

RDEPEND=">=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2
	>=dev-libs/libxml2-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/bonobo-activation-2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/ORBit2-2
	>=gnome-base/gnome-vfs-2
	=net-www/mozilla-1.4*
	app-text/scrollkeeper"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"

pkg_setup () {
	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk2.so ]
	then
		eerror "you need mozilla-1.4 compiled against gtk+-2"
		eerror "export USE=\"gtk2\" ;emerge mozilla -p "
		die "Need Mozilla compiled with gtk+-2.0!!"
	fi
}

pkg_postinst() {
	einfo "Gconf keys for some settings have changed,"
	einfo "you may have to reset some settings."
}
