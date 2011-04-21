# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-4.4.11.1.ebuild,v 1.1 2011/04/21 21:21:12 dilfridge Exp $

EAPI=4

KDE_MINIMAL="4.6"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

RDEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	$(add_kdebase_dep libkdepim)
"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-libs/libxslt
"

KMEXTRACTONLY="
	kmail/
"

src_configure() {
	mycmakeargs=(
		-DBUILD_akonadi=OFF
		-DXSLTPROC_EXECUTABLE="${EPREFIX}"/usr/bin/xsltproc
	)
	kde4-meta_src_configure
}
