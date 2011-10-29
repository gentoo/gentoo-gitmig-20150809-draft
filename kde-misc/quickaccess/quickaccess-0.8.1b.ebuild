# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/quickaccess/quickaccess-0.8.1b.ebuild,v 1.3 2011/10/29 00:10:27 abcd Exp $

EAPI=4

inherit kde4-base

MY_PN="plasma-widget-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="KDE4 plasmoid. Designed for the panel, provides quick access to the most used folders"
HOMEPAGE="http://kde-look.org/content/show.php?content=134442"
SRC_URI="http://kde-look.org/CONTENT/content-files/134442-plasma-widget-quickaccess-KDE4.5.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/quickaccess
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${MY_PN}-KDE4.5"

PATCHES=( "${FILESDIR}/${PN}-0.8.1-gcc46.patch" )
