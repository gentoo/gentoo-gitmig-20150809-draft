# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-systray/xchat-systray-2.4.0.ebuild,v 1.1 2004/01/04 02:11:53 pyrania Exp $

S=${WORKDIR}/${PN}-integration-${PV}
DESCRIPTION="System tray plugin for X-Chat."
SRC_URI="mirror://sourceforge/xchat2-plugins/${PN}-integration-${PV}-src.tar.gz"
HOMEPAGE="http://blight.altervista.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	>=net-irc/xchat-2.0.3"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.7"

src_compile() {
	MAKEOPTS="-j1" emake || die "Compile failed"
}

src_install() {
	insinto /usr/lib/xchat/plugins
	doins systray.so
}
