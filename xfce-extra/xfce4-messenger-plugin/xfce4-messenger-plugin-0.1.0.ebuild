# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-messenger-plugin/xfce4-messenger-plugin-0.1.0.ebuild,v 1.2 2011/12/02 19:49:14 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="A plugin that listens DBus messages and displays received messages"
HOMEPAGE="http://packages.qa.debian.org/x/xfce4-messenger-plugin.html"
SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/${PN}/${PN}_${PV}-5.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2
	sys-apps/dbus
	x11-libs/gtk+:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS README TODO )
}

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX=patch EPATCH_SOURCE="${WORKDIR}"/debian/patches epatch
	xfconf_src_prepare
}

src_install() {
	xfconf_src_install

	exeinto /usr/share/doc/${PF}/scripts
	doexe scripts/xfce-messenger-logtail
}
