# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kshutdown/kshutdown-2.0_beta8.ebuild,v 1.1 2009/10/25 15:35:52 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar bg cs de el es fr hu it nb nl pl pt_BR ru sk sr@latin sr sv tr zh_CN"
KDE_MINIMAL=4.2

inherit kde4-base

MY_P=${PN}-source-${PV/_}

DESCRIPTION="A shutdown manager for KDE"
HOMEPAGE="http://kshutdown.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=kde-base/libkworkspace-${KDE_MINIMAL}"
RDEPEND="${DEPEND}
	app-arch/unzip"

S=${WORKDIR}/${P/_}

src_prepare() {
	# remove precompiled crap
	rm -rf "${S}"/po/*.mo
	# use our own cmake for locales
	cp "${FILESDIR}"/CMakeLists.txt "${S}"/po/
	kde4-base_src_prepare
}
