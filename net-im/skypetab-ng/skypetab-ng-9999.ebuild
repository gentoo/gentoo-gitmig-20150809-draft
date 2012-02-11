# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skypetab-ng/skypetab-ng-9999.ebuild,v 1.1 2012/02/11 10:47:39 slyfox Exp $

EAPI=4

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/kekekeks/skypetab-ng.git"
	LIVE_ECLASSES="git-2"
	LIVE_EBUILD=yes
fi
MY_P=${P/_pre*//}

inherit qt4-r2 multilib ${LIVE_ECLASSES}

if [[ -z ${LIVE_EBUILD} ]]; then
	KEYWORDS="-* ~x86 ~amd64"
	SRC_URI="http://dev.gentoo.org/~slyfox/${P}.tar.gz"
fi

DESCRIPTION="An LD_PRELOAD wrapper that adds tabs to Skype for Linux"
HOMEPAGE="http://github.com/kekekeks/skypetab-ng"
LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/qt-gui
	amd64? ( app-emulation/emul-linux-x86-qtlibs )
"
RDEPEND="${DEPEND}
	net-im/skype
"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	use amd64 && multilib_toolchain_setup x86
}
