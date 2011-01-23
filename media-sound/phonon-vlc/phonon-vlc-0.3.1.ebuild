# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon-vlc/phonon-vlc-0.3.1.ebuild,v 1.4 2011/01/23 05:18:30 reavertm Exp $

EAPI="2"

MY_PN="phonon-backend-vlc"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/${MY_PN}/${PV}/src/${MY_PN}-${PV}.tar.bz2"
else
	EGIT_REPO_URI="git://gitorious.org/phonon/${PN}.git"
	GIT_ECLASS="git"
fi

inherit cmake-utils ${GIT_ECLASS}

DESCRIPTION="Phonon VLC backend"
HOMEPAGE="http://gitorious.org/phonon/phonon-vlc"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/libv4l
	>=media-sound/phonon-4.4.0
	>=media-video/vlc-1.1.1[dbus]
	>=x11-libs/qt-test-4.4.0:4
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	>=x11-libs/qt-opengl-4.4.0:4
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.86
	dev-util/pkgconfig
"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_postinst() {
	elog "For more verbose debug information, export the following variables:"
	elog "PHONON_VLC_DEBUG=3"
	elog "PHONON_DEBUG=1"
	elog ""
	elog "To make KDE detect the new backend without reboot, run:"
	elog "kbuildsycoca4 --noincremental"
}
