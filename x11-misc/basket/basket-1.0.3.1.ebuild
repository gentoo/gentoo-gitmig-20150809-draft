# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-1.0.3.1.ebuild,v 1.4 2009/05/30 19:22:21 nixnut Exp $

EAPI="2"

ARTS_REQUIRED="never"

USE_KEG_PACKAGING="1"

LANGS="cs da de es fr it ja nl nn pt ru tr zh_CN"

inherit kde

IUSE="crypt"

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/${P}.tar.gz"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~x86"

DEPEND="crypt? ( >=app-crypt/gpgme-1.0 )
	!<x11-misc/basket-1.0.3.1"
RDEPEND="${DEPEND}"

need-kde 3.3

src_install() {
	kde_src_install

	local dir="${KDEDIR}/share/services/kontact"

	# http://basket.kde.org/news.php#the-2008-02-28
	insinto "${dir}"
	# 6 and 7 work for up to 3.5.10
	for version in 6 7; do
		einfo "Creating additional Kontact plug-in file for version ${version}"
		newins kontact_plugin/basket.desktop basket_v${version}.desktop
		dosed "s:^X-KDE-KontactPluginVersion=5:X-KDE-KontactPluginVersion=${version}:" \
		"${dir}/basket_v${version}.desktop"
	done
}
