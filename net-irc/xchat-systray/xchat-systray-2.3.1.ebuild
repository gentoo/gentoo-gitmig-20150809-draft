# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-systray/xchat-systray-2.3.1.ebuild,v 1.2 2003/09/06 22:02:56 msterret Exp $

S=${WORKDIR}/${PN}-plugin_${PV}
DESCRIPTION="KDE/GNOME system tray plugin for X-Chat."
SRC_URI="http://blight.altervista.org/Downloads/${PN}-plugin_${PV}.tar.gz"
HOMEPAGE="http://blight.altervista.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	sys-devel/gettext"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	>=net-irc/xchat-2.0.3"

src_compile() {

	MAKEOPTS="-j1" emake || die "Compile failed"
}

src_install() {
	insinto /usr/lib/xchat/plugins
	doins systray.so
}
