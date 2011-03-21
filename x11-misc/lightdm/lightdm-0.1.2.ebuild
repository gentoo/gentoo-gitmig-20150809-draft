# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/lightdm-0.1.2.ebuild,v 1.3 2011/03/21 23:28:06 nirbheek Exp $

EAPI=2
inherit autotools eutils pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://launchpad.net/lightdm"
SRC_URI="http://people.ubuntu.com/~robert-ancell/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="consolekit +introspection nls webkit"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	x11-libs/gtk+:2
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libxklavier
	virtual/pam
	consolekit? ( sys-auth/consolekit )
	introspection? ( dev-libs/gobject-introspection )
	webkit? ( net-libs/webkit-gtk:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

src_prepare() {
	# hardcoded service name to start PAM session
	sed -i -e "s:check_pass:${PN}:" src/pam-session.c || die
	# Fix ubuntu way of launching WM
	sed -i -e "s:/etc/X11/Xsession::" src/display.c || die

	epatch "${FILESDIR}"/${PN}-0.1.1-webkit.patch
	eautoreconf
}

src_configure() {
	econf \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable webkit) \
		$(use_enable introspection) \
		$(use_enable consolekit console-kit) \
		$(use_enable nls) \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	pamd_mimic system-local-login lightdm auth account session
	dodoc ChangeLog NEWS
	find "${D}" -name '*.la' -exec rm -f '{}' +
}
