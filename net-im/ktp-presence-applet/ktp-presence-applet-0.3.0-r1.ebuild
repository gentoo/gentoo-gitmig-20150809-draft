# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ktp-presence-applet/ktp-presence-applet-0.3.0-r1.ebuild,v 1.1 2012/01/27 10:36:33 johu Exp $

EAPI=4

KDE_SCM="git"
KDE_LINGUAS="cs da de es et ga hu it ja lt nds nl pl pt pt_BR sv uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE Telepathy presence applet"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt-0.9.0
"
RDEPEND="${DEPEND}
	>=net-im/ktp-contact-list-${PV}
"

PATCHES=(
	"${FILESDIR}/${P}-fix-multi-linguas.patch"
)
