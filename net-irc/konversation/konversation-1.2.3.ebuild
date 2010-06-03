# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-1.2.3.ebuild,v 1.3 2010/06/03 11:11:15 hwoarang Exp $

EAPI=2
KDE_LINGUAS="bg ca cs da de el en_GB es et fi fr gl he hu it ja nb nds nl pl pt
pt_BR ru sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

DESCRIPTION="A user friendly IRC Client for KDE4"
HOMEPAGE="http://konversation.kde.org"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 ~x86"
IUSE="+crypt debug +handbook"

DEPEND="x11-libs/libXScrnSaver
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	crypt? ( app-crypt/qca:2 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_configure() {
	mycmakeargs+=(
		$(cmake-utils_use_with crypt QCA2)
		)

	kde4-base_src_configure
}
