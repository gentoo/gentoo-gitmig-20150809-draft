# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alltray/alltray-0.74.ebuild,v 1.3 2010/07/29 19:04:11 hwoarang Exp $

# remove this kludge once old releases have been removed from the tree
MY_PV="${PV:0:1}.${PV:2:1}.${PV:3:1}"
MY_PV_DEV="${MY_PV}dev"
MY_P="${PN}-${MY_PV}"
MY_P_DEV="${PN}-${MY_PV_DEV}"

EAPI="2"

inherit eutils

DESCRIPTION="Dock any application into the system tray/notification area"
HOMEPAGE="http://alltray.trausch.us/"
SRC_URI="http://code.launchpad.net/${PN}/trunk/${MY_PV_DEV}/+download/${MY_P_DEV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/libwnck
	x11-libs/libX11"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

S="${WORKDIR}/${MY_P_DEV}"

src_prepare() {
	epatch "${FILESDIR}"/${MY_P}-include-fixes.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
