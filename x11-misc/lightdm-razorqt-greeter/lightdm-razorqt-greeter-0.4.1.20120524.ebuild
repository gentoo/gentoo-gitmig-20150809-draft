# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm-razorqt-greeter/lightdm-razorqt-greeter-0.4.1.20120524.ebuild,v 1.1 2012/05/30 14:12:48 yngwin Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="LightDM greeter for Razor-qt"
HOMEPAGE="http://razor-qt.org"

if [[ ${PV} = *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/Razor-qt/razor-qt.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	SRC_URI="mirror://gentoo/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-misc/lightdm[qt4]
	=x11-wm/razorqt-0.4.1*"
DEPEND="${RDEPEND}"

pkg_postinst() {
	echo
	elog 'To use the Razor-qt LightDM greeter, make sure to configure LightDM'
	elog 'with greeter-session = lightdm-razor-greeter'
	elog 'or set LIGHTDM_GREETER=lightdm-razor-greeter in /etc/make.conf and'
	elog 'rebuild x11-misc/lightdm'
	echo
}
