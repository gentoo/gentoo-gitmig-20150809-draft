# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/prefsmodule/prefsmodule-1.1.1_pre20061204.ebuild,v 1.2 2007/08/22 16:50:11 angelos Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="cvs.savannah.nongnu.org:/sources/backbone"
ECVS_USER="anoncvs"
ECVS_PASS="anoncvs"
ECVS_AUTH="pserver"
ECVS_MODULE="System"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/cvs.savannah.nongnu.org-backbone"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}/Frameworks/${PN/prefsm/PrefsM}

DESCRIPTION="Preferences is the GNUstep program with which you define your own personal user experience."
HOMEPAGE="http://www.nongnu.org/backbone/apps.html"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_compile() {
	# remove CVS dirs, bug #154155
	find "${S}" -type d -name "CVS" | xargs rm -Rf

	gnustep_src_compile || die "compile failed"
}
