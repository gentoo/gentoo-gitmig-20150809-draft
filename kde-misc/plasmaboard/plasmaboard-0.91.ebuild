# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasmaboard/plasmaboard-0.91.ebuild,v 1.2 2011/01/31 06:15:30 tampakrap Exp $

EAPI=3
inherit kde4-base

DESCRIPTION="A virtual keyboard for your desktop"
HOMEPAGE="http://www.kde-look.org/content/show.php/Plasmaboard?content=101822"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/101822-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${PN}

DOCS=( AUTHORS README )
