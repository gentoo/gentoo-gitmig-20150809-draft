# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-systray/xchat-systray-2.4.5-r1.ebuild,v 1.5 2005/05/16 15:59:33 swegener Exp $

inherit flag-o-matic eutils toolchain-funcs

MY_P=${PN}-integration-${PV}

DESCRIPTION="System tray plugin for X-Chat."
SRC_URI="mirror://sourceforge/xchat2-plugins/${MY_P}-src.tar.gz"
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

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-segfault-fix.patch
}

src_compile() {
	append-flags -fPIC
	emake -j1 CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe systray.so || die "doexe failed"

	insinto /usr/share/xchat-systray
	doins -r src/images/{GTKTray,Menu} || die "doins failed"

	dodoc Docs/{ChangeLog,README,TODO} || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "As of 2.4.5 the images will be installed seperately and will not be included"
	einfo "in the binary. The images have been installed in /usr/share/xchat-systray"
	einfo
	einfo "Please update your settings accordingly!"
	einfo
}
