# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/projectcenter/projectcenter-0.4.1_pre20041203.ebuild,v 1.1 2004/12/04 20:20:16 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/dev-apps/${PN/projectc/ProjectC}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="An IDE for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/ProjectCenter.html"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}
	>=sys-devel/gdb-6.0"

egnustep_install_domain "System"

src_unpack() {
	cvs_src_unpack
	egnustep_env
	cd ${S}
	if [ -z "${GNUSTEP_FLATTENED}" ]; then
		epatch ${FILESDIR}/pc-non-flattened.patch
	fi
}

