# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kplayer/kplayer-0.7.1.ebuild,v 1.6 2011/11/12 21:04:43 dilfridge Exp $

EAPI=4

KDE_LINGUAS="be bg br bs ca ca@valencia cs cy da de el en_GB eo es et eu fi fr
ga gl he hi hne hr hu it ja km ku lt mai nb nds nl nn oc pa pl pt pt_BR ro ru
sr sr@ijekavian sr@ijekavianlatin sr@latin sv th tr ug uk zh_CN zh_TW"
KDE_HANDBOOK=optional
inherit kde4-base

DESCRIPTION="KPlayer is a KDE media player based on mplayer."
HOMEPAGE="https://projects.kde.org/projects/extragear/multimedia/kplayer"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="${DEPEND}
	|| ( >=media-video/mplayer-1.0_rc1 media-video/mplayer2 )
"

PATCHES=( "${FILESDIR}/${P}-enablefinal.patch" )
