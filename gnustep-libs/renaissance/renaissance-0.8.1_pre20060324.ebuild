# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/renaissance/renaissance-0.8.1_pre20060324.ebuild,v 1.3 2007/08/18 15:29:22 angelos Exp $

inherit gnustep

# doc is broken
IUSE="${IUSE}"

DESCRIPTION="GNUstep Renaissance allows to describe user interfaces XML files"
HOMEPAGE="http://www.gnustep.it/Renaissance/index.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~amd64 x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

src_install() {
	cd ${S}
	egnustep_env
	egnustep_install || die
#	if use doc ; then
#		egnustep_env
#		cd Documentation
#		egnustep_make
#		egnustep_install
#		mkdir -p ${TMP}/tmpdocs
#		mv ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/* ${T}/tmpdocs
#		mkdir -p ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/Developer/Renaissance
#		mv ${T}/tmpdocs/* ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/Developer/Renaissance
#		cd ..
#	fi
	egnustep_package_config
}
