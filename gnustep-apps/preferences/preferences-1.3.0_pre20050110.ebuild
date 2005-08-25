# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/preferences/preferences-1.3.0_pre20050110.ebuild,v 1.2 2005/08/25 18:57:12 swegener Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/backbone"
ECVS_USER="anoncvs"
ECVS_AUTH="no"
ECVS_MODULE="System"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-backbone"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}/Applications/${PN/p/P}

DESCRIPTION="Preferences is the GNUstep program with which you define your own personal user experience."
HOMEPAGE="http://www.nongnu.org/backbone/apps.html"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	=gnustep-libs/prefsmodule-1.1.1${PV/*_/_}*"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	cvs_src_unpack
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/Preferences-nocreate-extra-dirs.patch
}
