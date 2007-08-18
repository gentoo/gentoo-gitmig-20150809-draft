# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/stepulator/stepulator-1.0-r1.ebuild,v 1.3 2007/08/18 15:24:12 angelos Exp $

inherit gnustep

S=${WORKDIR}/${PN/s/S}-gs

DESCRIPTION="A Reverse Polish Notation calculator"
HOMEPAGE="http://www.linuks.mine.nu/stepulator/index.html"
SRC_URI="http://www.linuks.mine.nu/stepulator/${PN}-gs-${PV}.tar.Z"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"
