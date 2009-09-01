# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelirc/kdelirc-4.3.1.ebuild,v 1.2 2009/09/01 21:46:18 wired Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE frontend for the Linux Infrared Remote Control system"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

RDEPEND="
	!kde-misc/kdelirc
	app-misc/lirc
"

src_prepare() {
	kde4-meta_src_prepare

	sed -i "/kscd.profile/d" "${S}"/kdelirc/profiles/CMakeLists.txt ||
		die "collision fixing sed failed"
}
