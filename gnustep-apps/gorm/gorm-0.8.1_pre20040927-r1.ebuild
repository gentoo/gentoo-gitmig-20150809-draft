# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gorm/gorm-0.8.1_pre20040927-r1.ebuild,v 1.3 2004/11/12 03:53:07 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/dev-apps/${PN/g/G}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

IUSE="${IUSE} doc"
DESCRIPTION="Gorm is a clone of the NeXTstep Interface Builder application for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/Gorm.html"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}
	doc? sys-apps/sed"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	cvs_src_unpack
	sed -i -e "/DOCUMENT_NAME =.*/a \Gorm_DOC_INSTALL_DIR=Developer/Gorm" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \ANNOUNCE_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \README_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \NEWS_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \INSTALL_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		${S}/Documentation/GNUmakefile
}

