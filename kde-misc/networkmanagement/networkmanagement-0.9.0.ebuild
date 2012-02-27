# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/networkmanagement/networkmanagement-0.9.0.ebuild,v 1.1 2012/02/27 18:42:38 johu Exp $

EAPI=4

KDE_MINIMAL="4.6"
KDE_LINGUAS="ar bs ca ca@valencia cs da de el en_GB eo es et fi fr ga gl hr hu
is it ja km ko lt lv mai ms nb nds nl nn pa pl pt pt_BR ro ru sk sl sq sv th tr
ug uk wa zh_CN zh_TW"

KDE_SCM="git"
EGIT_REPONAME="${PN}"
inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep solid)
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.9.0
"
RDEPEND="${DEPEND}"
