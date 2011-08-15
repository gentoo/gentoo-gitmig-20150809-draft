# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaccessible/kaccessible-4.6.5.ebuild,v 1.3 2011/08/15 19:01:05 maekke Exp $

EAPI=4

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="Provides accessibility services like focus tracking"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +speechd"

DEPEND="app-accessibility/speech-dispatcher"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with speechd Speechd)
	)
	kde4-meta_src_configure
}
