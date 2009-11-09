# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-1.0_pre2.ebuild,v 1.3 2009/11/09 14:01:12 maekke Exp $

EAPI=2
KDE_LINGUAS="cs da de el en_GB es et fi fr ga gl hu it ja km ko ku lt mai nb nds
nl nn pa pl pt pt_BR ro ru se sk sv th tr uk zh_CN zh_TW"
KDE_MINIMAL=4.2
MY_P=${P/_/-}

inherit kde4-base

DESCRIPTION="A media player for KDE with digital TV support"
HOMEPAGE="http://kaffeine.kde.org/"
SRC_URI="mirror://sourceforge/kaffeine/${MY_P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="debug"

DEPEND=">=kde-base/phonon-kde-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}"

S=${WORKDIR}/${MY_P}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_build debug DEBUG_MODULE)"
	kde4-base_src_configure
}
