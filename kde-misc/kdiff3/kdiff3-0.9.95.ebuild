# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdiff3/kdiff3-0.9.95.ebuild,v 1.6 2009/06/25 08:18:43 mr_bones_ Exp $

EAPI="2"

KDE_LINGUAS="ar bg br cs cy da de el en_GB es et fr ga gl hi hu it ja ka lt nb
nds nl pl pt pt_BR ro ru rw sv ta tg tr uk zh_CN"
inherit kde4-base

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug handbook konqueror"

RDEPEND="konqueror? ( >=kde-base/libkonq-${KDE_MINIMAL} )
	sys-apps/diffutils
	!kde-misc/kdiff3:0"

src_configure() {
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_with konqueror LibKonq)"
	kde4-base_src_configure
}
