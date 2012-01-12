# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdemu/kcdemu-0.3.1-r1.ebuild,v 1.1 2012/01/12 00:10:53 johu Exp $

EAPI=4
KDE_LINGUAS="de es pl ro"
inherit kde4-base

MY_PN='kde_cdemu'

DESCRIPTION="A frontend to cdemu daemon for KDE4"
HOMEPAGE="http://www.kde-apps.org/content/show.php/KDE+CDEmu+Manager?content=99752"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/99752-${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=app-cdr/cdemu-1.2.0"

PATCHES=(
	"${FILESDIR}/${P}-start-cdemud.patch"
)

S=${WORKDIR}/${MY_PN}

DOCS=( ChangeLog )
