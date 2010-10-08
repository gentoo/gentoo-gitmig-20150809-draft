# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdemu/kcdemu-0.3.ebuild,v 1.3 2010/10/08 12:21:09 hwoarang Exp $

EAPI=3
KDE_LINGUAS="de es"
inherit kde4-base

MY_P=kde_cdemu-${PV}

DESCRIPTION="A frontend to cdemu daemon for KDE4"
HOMEPAGE="http://www.kde-apps.org/content/show.php/KDE+CDEmu+Manager?content=99752"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/99752-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~x86"
IUSE="debug"

RDEPEND=">=app-cdr/cdemu-1.2.0"

S=${WORKDIR}/${MY_P}

DOCS=( ChangeLog )
