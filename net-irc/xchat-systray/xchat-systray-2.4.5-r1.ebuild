# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-systray/xchat-systray-2.4.5-r1.ebuild,v 1.2 2004/09/05 13:34:05 gmsoft Exp $

inherit flag-o-matic eutils

MY_P=${PN}-integration-${PV}

DESCRIPTION="System tray plugin for X-Chat."
SRC_URI="mirror://sourceforge/xchat2-plugins/${MY_P}-src.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://blight.altervista.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha hppa"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	>=net-irc/xchat-2.0.3"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.7"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-segfault-fix.patch
}

src_compile() {
	append-flags -fPIC
	emake -j1 CFLAGS="${CFLAGS}" || die "Compile failed"
}

src_install() {
	exeinto /usr/lib/xchat/plugins
	doexe systray.so

	insinto /usr/share/xchat-systray/GTKTray
	doins src/images/GTKTray/*

	insinto /usr/share/xchat-systray/Menu
	doins src/images/Menu/*

	dodoc Docs/*
}

pkg_postinst() {
	einfo
	einfo "As of 2.4.5 the images will be installed seperately and will not be included"
	einfo "in the binary. The images have been installed in /usr/share/xchat-systray"
	einfo
	einfo "Please update your settings accordingly!"
	einfo
}
