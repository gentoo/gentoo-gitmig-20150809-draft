# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.6.6_pre20040928.ebuild,v 1.2 2005/01/09 10:55:52 swegener Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/usr-apps/${PN}"
ECVS_CO_OPTS="-D ${PV/*_pre}"
ECVS_UP_OPTS="-D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="A workspace manager for GNUstep."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="${IUSE} imagekits"
DEPEND="${GS_DEPEND}
	imagekits? ( gnustep-libs/imagekits )"
RDEPEND="${GS_RDEPEND}"

src_compile() {
	egnustep_env

	econf || die "configure failed"

	egnustep_make
}

