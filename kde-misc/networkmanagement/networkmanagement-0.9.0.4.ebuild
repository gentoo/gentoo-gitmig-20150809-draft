# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/networkmanagement/networkmanagement-0.9.0.4.ebuild,v 1.1 2012/07/30 07:23:28 scarabeus Exp $

EAPI=4

KDE_MINIMAL="4.6"
KDE_LINGUAS="ar ca cs da de el es et fa fi ga hu it ja km lt nb nds nl nn pl pt
pt_BR se sk sr sr@latin sr@ijekavian sr@ijekavianlatin sv tr uk zh_TW"

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
