# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-9999.ebuild,v 1.10 2011/09/10 12:21:34 hwoarang Exp $

EAPI="2"

WANT_AUTOMAKE="1.9"
inherit autotools fdo-mime git

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
HOMEPAGE="http://icculus.org/openbox/index.php/ObConf:About"
EGIT_REPO_URI="git://git.openbox.org/dana/obconf.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="lxde nls"

RDEPEND="gnome-base/libglade:2.0
	x11-libs/gtk+:2
	x11-libs/startup-notification
	=x11-wm/openbox-9999"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	if use lxde; then
		sed -i -e "/^Exec/s:obconf.*$:obconf-lxde:" ${PN}.desktop || die
	fi
	eautopoint
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use lxde; then
		dobin "${FILESDIR}"/${PN}-lxde || die
	fi
	dodoc AUTHORS CHANGELOG README || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
