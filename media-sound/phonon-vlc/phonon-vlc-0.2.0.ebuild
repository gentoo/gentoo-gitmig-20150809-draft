# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon-vlc/phonon-vlc-0.2.0.ebuild,v 1.3 2011/01/06 00:32:07 jmbsvicetto Exp $

EAPI="2"

MY_PN="phonon-backend-vlc"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/${MY_PN}/${PV}/src/${MY_PN}-${PV}.tar.gz"
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
	>=media-sound/phonon-4.4.0
	>=media-video/vlc-1.1[dbus]
	>=x11-libs/qt-test-4.4.0:4
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	>=x11-libs/qt-opengl-4.4.0:4
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.86
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
