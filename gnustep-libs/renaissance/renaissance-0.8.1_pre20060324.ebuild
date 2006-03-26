# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/renaissance/renaissance-0.8.1_pre20060324.ebuild,v 1.1 2006/03/26 09:01:37 grobian Exp $

inherit gnustep subversion

# doc is broken
IUSE="${IUSE}"

ESVN_OPTIONS="-r{${PV/*_pre}}"
ESVN_REPO_URI="http://svn.gna.org/svn/gnustep/libs/${PN}/trunk"
ESVN_STORE_DIR="${DISTDIR}/svn-src/svn.gna.org-gnustep/libs"

S=${WORKDIR}/${PN}

DESCRIPTION="GNUstep Renaissance allows to describe user interfaces XML files"
HOMEPAGE="http://www.gnustep.it/Renaissance/index.html"

KEYWORDS="x86"
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
