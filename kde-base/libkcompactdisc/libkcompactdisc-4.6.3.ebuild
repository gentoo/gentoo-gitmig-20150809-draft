# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcompactdisc/libkcompactdisc-4.6.3.ebuild,v 1.2 2011/06/08 23:26:32 tomka Exp $

EAPI=4

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="alsa debug"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	kde4-meta_src_configure
}
