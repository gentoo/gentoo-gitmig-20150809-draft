# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kigo/kigo-4.9.2.ebuild,v 1.1 2012/10/02 18:11:58 johu Exp $

EAPI=4

if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdegames"
fi
KDE_HANDBOOK="optional"
inherit games-ggz ${eclass}

DESCRIPTION="KDE Go game"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	games-board/gnugo
"

src_install() {
	${eclass}_src_install
	# and also we have to prepare the ggz dir
	insinto "${GGZ_MODDIR}"
	if [[ ${PV} == *9999 ]]; then
		newins src/module.dsc ${P}.dsc
	else
		newins ${PN}/src/module.dsc ${P}.dsc
	fi
}

pkg_postinst() {
	${eclass}_pkg_postinst
	games-ggz_pkg_postinst
}

pkg_postrm() {
	${eclass}_pkg_postrm
	games-ggz_pkg_postrm
}
