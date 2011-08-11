# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-4.4.11.1-r1.ebuild,v 1.5 2011/08/11 20:05:44 dilfridge Exp $

EAPI=4

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

RDEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop' 4.6)
	$(add_kdebase_dep libkdepim)
"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-libs/libxslt
"

KMEXTRACTONLY="
	kmail/
"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.11.1-crash.patch"
	"${FILESDIR}/${PN}-4.4.11.1-underlinking.patch"
)

src_configure() {
	mycmakeargs=(
		-DBUILD_akonadi=OFF
		-DXSLTPROC_EXECUTABLE="${EPREFIX}"/usr/bin/xsltproc
	)
	kde4-meta_src_configure
}
