# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/lightdm-0.1.1.ebuild,v 1.4 2011/03/21 23:28:06 nirbheek Exp $

EAPI=2

inherit autotools eutils pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://launchpad.net/lightdm"
SRC_URI="http://people.ubuntu.com/~robert-ancell/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="consolekit doc nls webkit"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	webkit? ( net-libs/webkit-gtk:2 )
	consolekit? ( sys-auth/consolekit )
	x11-libs/gtk+:2
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libxklavier
	virtual/pam"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )
	nls? ( dev-util/intltool )"

src_prepare() {
	# hardcoded service name to start PAM session
	sed -e "s/check_pass/${PN}/" -i src/pam-session.c || die #report me upstream
	# Fix ubuntu way of launching WM
	sed -e "s:/etc/X11/Xsession::" -i src/display.c || die #report me upstream

	epatch "${FILESDIR}"/${P}-webkit.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable doc gtk-doc) \
		$(use_enable webkit) \
		--disable-dependency-tracking \
		--disable-introspection \
		$(use_enable consolekit console-kit) \
		$(use_enable nls) \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--localstatedir=/var  #overcoming econf default (fix me?)

}

src_install() {
	emake DESTDIR="${D}" install || die
	pamd_mimic system-local-login lightdm auth account session
	dodoc ChangeLog NEWS || die
	find "${D}" -name '*.la' -exec rm -f '{}' +
}
