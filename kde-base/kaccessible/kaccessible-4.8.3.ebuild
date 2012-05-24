# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaccessible/kaccessible-4.8.3.ebuild,v 1.4 2012/05/24 08:11:56 ago Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Provides accessibility services like focus tracking"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +speechd"

DEPEND="speechd? ( app-accessibility/speech-dispatcher )"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with speechd)
	)
	kde4-base_src_configure
}
