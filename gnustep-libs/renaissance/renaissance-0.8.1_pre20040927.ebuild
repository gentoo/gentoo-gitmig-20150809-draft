# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/renaissance/renaissance-0.8.1_pre20040927.ebuild,v 1.2 2004/10/17 10:02:19 dholm Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/dev-libs/${PN/r/R}"
ECVS_CO_OPTS="-D ${PV/*_pre}"
ECVS_UP_OPTS="-D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="GNUstep Renaissance allows you to describe your user interfaces in simple and intuitive XML files."
HOMEPAGE="http://www.gnustep.it/Renaissance/index.html"

KEYWORDS="~x86 ~ppc"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="${IUSE} doc"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

src_install() {
	cd ${S}
	egnustep_env
	egnustep_install || die
	if [ `use doc` ]; then
		egnustep_env
		cd Documentation
		egnustep_make
		egnustep_install
		mkdir -p ${TMP}/tmpdocs
		mv ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/* ${TMP}/tmpdocs
		mkdir -p ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/Developer/Renaissance
		mv ${TMP}/tmpdocs/* ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Documentation/Developer/Renaissance
		cd ..
	fi
	egnustep_package_config
}

