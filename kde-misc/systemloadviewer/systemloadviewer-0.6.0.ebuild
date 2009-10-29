# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/systemloadviewer/systemloadviewer-0.6.0.ebuild,v 1.1 2009/10/29 08:21:41 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="a simple plasmoid meant to display cpu, ram, and swap usage"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=74891"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/74891-${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${PN}

DOCS="AUTHORS"
