# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxsldbg/kxsldbg-4.3.5.ebuild,v 1.4 2010/06/21 15:53:16 scarabeus Exp $

EAPI="2"

KMNAME="kdewebdev"
inherit kde4-meta

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	dev-libs/libxslt
	dev-libs/libxml2
"
RDEPEND="${DEPEND}"

src_unpack() {
	if use handbook; then
		KMEXTRA="doc/xsldbg"
	fi

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs=(-DWITH_LibXml2=ON -DWITH_Xslt=ON)

	kde4-meta_src_configure
}
