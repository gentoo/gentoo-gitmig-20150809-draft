# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcompactdisc/libkcompactdisc-4.0.0.ebuild,v 1.1 2008/01/18 01:27:13 ingmar Exp $

EAPI="1"

KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug htmlhandbook"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)"
	kde4-meta_src_compile
}
