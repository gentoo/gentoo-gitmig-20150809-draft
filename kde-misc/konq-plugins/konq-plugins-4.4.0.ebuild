# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/konq-plugins/konq-plugins-4.4.0.ebuild,v 1.3 2010/06/28 06:21:44 fauli Exp $

EAPI=2

KDE_MINIMAL=4.4

# FIXME. Missing sr@ijekavian in desc.
KDE_LINGUAS="af ar ast be bg bn br ca ca@valencia cs cy da de el en_GB eo es et
eu fa fi fr fy ga gl he hi hne hr hsb hu is it ja kk km ko ku lt lv mai ml ms nb
nds ne nl nn oc pa pl pt pt_BR ro ru se sk sl sr sv ta tg th tr uk uz
uz@cyrillic vi xh zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"

inherit kde4-base

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="http://kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="debug +handbook tidy"

DEPEND=">=kde-base/libkonq-${KDE_MINIMAL}
	tidy? ( app-text/htmltidy )"
RDEPEND="${DEPEND}
	>=kde-base/kcmshell-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}"

src_configure() {
	mycmakeargs+=(
		$(cmake-utils_use_with tidy LibTidy)
		)

	kde4-base_src_configure
}
