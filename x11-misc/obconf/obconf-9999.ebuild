# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-9999.ebuild,v 1.1 2010/02/05 15:37:39 hwoarang Exp $

EAPI="2"

inherit fdo-mime git

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
HOMEPAGE="http://icculus.org/openbox/index.php/ObConf:About"
EGIT_REPO_URI="git://git.openbox.org/dana/obconf.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.4.2
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	./bootstrap || die "boostrap failed"
	econf \
		$(use_enable nls) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
