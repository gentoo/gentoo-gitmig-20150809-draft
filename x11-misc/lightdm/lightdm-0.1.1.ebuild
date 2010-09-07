# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/lightdm-0.1.1.ebuild,v 1.1 2010/09/07 18:35:47 xarthisius Exp $

EAPI=2

inherit eutils pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://launchpad.net/lightdm"
SRC_URI="http://people.ubuntu.com/~robert-ancell/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="consolekit nls"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	net-libs/webkit-gtk
	x11-libs/gtk+:2
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libxklavier
	consolekit? ( sys-auth/consolekit )
	virtual/pam"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

src_prepare() {
	# hardcoded service name to start PAM session
	sed -e "s/check_pass/${PN}/" -i src/pam-session.c || die #report me upstream
	# Fix ubuntu way of launching WM
	sed -e "s:/etc/X11/Xsession::" -i src/display.c || die #report me upstream
}

src_configure() {
	econf \
		--disable-static \
		--disable-dependency-tracking \
		--disable-introspection \
		$(use_enable consolekit console-kit) \
		--disable-scrollkeeper \
		$(use_enable nls) \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--localstatedir=/var  #overcoming econf default (fix me?)

}

src_install() {
	emake DESTDIR="${D}" install || die
	pamd_mimic_system lightdm auth account password session
	dodoc ChangeLog NEWS || die
	find "${D}" -name '*.la' -exec rm -f '{}' +
}
