# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gridlock/gridlock-1.9.ebuild,v 1.2 2004/10/17 09:38:10 dholm Exp $

inherit gnustep

S=${WORKDIR}/${PN/g/G}

DESCRIPTION="Gridlock is a collection of grid-based games"
HOMEPAGE="http://dozingcat.com/"
SRC_URI="http://dozingcat.com/Gridlock/${PN/g/G}-gnustep-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="${IUSE} doc"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

src_install() {
	egnustep_env
	egnustep_install || die
	if use doc
	then
		mkdir -p ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/User/Gridlock
		cp Resources/readme.html ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/User/Gridlock
	fi
	egnustep_package_config
}

