# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-systray/xchat-systray-2.3.1.ebuild,v 1.8 2004/07/20 23:44:11 swegener Exp $

MY_P=${PN}-plugin_${PV}

DESCRIPTION="KDE/GNOME system tray plugin for X-Chat."
SRC_URI="http://blight.altervista.org/Downloads/${MY_P}.tar.gz"
HOMEPAGE="http://blight.altervista.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	>=net-irc/xchat-2.0.3"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	sys-devel/gettext
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s/-O2 -Wall/${CFLAGS}/" Makefile
}

src_compile() {
	emake -j1 || die "Compile failed"
}

src_install() {
	exeinto /usr/lib/xchat/plugins
	doexe systray.so
}
