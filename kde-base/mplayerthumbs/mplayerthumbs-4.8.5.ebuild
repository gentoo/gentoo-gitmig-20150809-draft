# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mplayerthumbs/mplayerthumbs-4.8.5.ebuild,v 1.5 2012/10/13 22:03:53 johu Exp $

EAPI=4

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="A Thumbnail Generator for Video Files on KDE filemanagers."
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	|| (
		$(add_kdebase_dep dolphin)
		$(add_kdebase_dep konqueror)
	)
"

src_configure() {
	mycmakeargs=(
		-DENABLE_PHONON_SUPPORT=ON
	)

	kde4-meta_src_configure
}
