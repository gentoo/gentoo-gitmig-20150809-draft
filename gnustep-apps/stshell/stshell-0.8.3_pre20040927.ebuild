# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/stshell/stshell-0.8.3_pre20040927.ebuild,v 1.3 2004/11/12 03:56:43 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/dev-libs/StepTalk/Examples/${PN/sts/S}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="An interactive shell for StepTalk."
HOMEPAGE="http://www.gnustep.org/experience/StepTalk.html"

KEYWORDS="~x86 ~ppc"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}
	=gnustep-libs/steptalk-${PV}*"
RDEPEND="${GS_RDEPEND}
	=gnustep-libs/steptalk-${PV}*"

egnustep_install_domain "System"

