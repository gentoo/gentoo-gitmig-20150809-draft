# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcoloredit/kcoloredit-4.0.4.ebuild,v 1.1 2008/05/15 22:56:03 ingmar Exp $

EAPI="1"

KDE_LINGUAS="af ar be bg br ca cs cy da de el en_GB eo es et eu fa fi fr ga gl
he hr hu is it ja km lt lv mk ms nb nds ne nl nn oc pa pl pt pt_BR ro ru se sk
sl sr sv ta tg th tr uk vi xh zh_CN zh_HK zh_TW"

NEED_KDE="${PV}"
inherit kde4-base

DESCRIPTION="KDE color selector/editor"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${PV}/src/extragear/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="kde-4"
IUSE="debug htmlhandbook"

PREFIX="${KDEDIR}"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/gettext"
