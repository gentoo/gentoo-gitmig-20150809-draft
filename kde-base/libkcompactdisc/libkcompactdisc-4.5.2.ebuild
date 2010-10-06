# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcompactdisc/libkcompactdisc-4.5.2.ebuild,v 1.1 2010/10/06 09:17:20 alexxy Exp $

EAPI="3"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa debug"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	kde4-meta_src_configure
}
