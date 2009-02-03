# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/skanlite/skanlite-0.2.ebuild,v 1.2 2009/02/03 21:41:39 mr_bones_ Exp $

EAPI="2"
KDE_MINIMAL="4.1"
KDE_LINGUAS="be cs da de el es et fr ga gl it ja km lt lv
			nb nds nl nn pa pl pt pt_BR ro sk sv tr uk wa zh_CN zh_TW"

inherit kde4-base

KDE_VERSION="4.2.0"
MY_P="${P}-kde${KDE_VERSION}"

DESCRIPTION="Cryptography for Kopete instant messenger."
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/libksane-${KDE_MINIMAL}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e 's/Icon=skanlite/Icon=scanner/' \
			-i skanlite.desktop || die "Sed failed for skanlite.desktop"
	kde4-base_src_prepare
}
