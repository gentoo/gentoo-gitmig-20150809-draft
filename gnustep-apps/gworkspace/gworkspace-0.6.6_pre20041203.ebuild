# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.6.6_pre20041203.ebuild,v 1.1 2004/12/04 20:22:29 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/usr-apps/${PN}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="A workspace manager for GNUstep."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"

KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="${IUSE} pdfkit"
DEPEND="${GS_DEPEND}
	pdfkit? ( gnustep-libs/pdfkit )
	>=dev-db/sqlite-3.0.8-r1"
RDEPEND="${GS_RDEPEND}
	>=dev-db/sqlite-3.0.8-r1"

egnustep_install_domain "System"

src_compile() {
	egnustep_env

	EPATCH_OPTIONS="-d ${S}" epatch ${FILESDIR}/seperate-desktop-recycler.patch

	econf || die "configure failed"

	egnustep_make
}

