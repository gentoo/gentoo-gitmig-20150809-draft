# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/stepulator/stepulator-1.0.ebuild,v 1.1 2004/09/25 23:57:49 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${PN/s/S}-gs

DESCRIPTION="A Reverse Polish Notation calculator"
HOMEPAGE="http://www.linuks.mine.nu/stepulator/index.html"
SRC_URI="http://www.linuks.mine.nu/stepulator/${PN}-gs-${PV}.tar.Z"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

