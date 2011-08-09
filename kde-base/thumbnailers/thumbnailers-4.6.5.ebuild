# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/thumbnailers/thumbnailers-4.6.5.ebuild,v 1.2 2011/08/09 17:12:16 hwoarang Exp $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	KMNAME="kdegraphics-thumbnailers"
	kde_eclass="kde4-base"
else
	KMNAME="kdegraphics"
	kde_eclass="kde4-meta"
fi

inherit ${kde_eclass}

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRACTONLY="
	libs/mobipocket
"

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
"
RDEPEND="${DEPEND}"

add_blocker kdegraphics-strigi-analyzer '<4.2.91'

if [[ ${PV} != *9999 ]]; then
src_install() {
	kde4-meta_src_install

	# why, oh why?!
	rm "${ED}/usr/share/apps/cmake/modules/FindKSane.cmake" || die
}
fi
