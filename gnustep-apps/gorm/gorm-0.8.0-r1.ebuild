# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gorm/gorm-0.8.0-r1.ebuild,v 1.2 2004/11/12 03:53:07 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${P/g/G}

DESCRIPTION="Gorm is a clone of the NeXTstep Interface Builder application for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/Gorm.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/${P/g/G}.tar.gz"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE="${IUSE} doc"
DEPEND="${GS_DEPEND}
	doc? sys-apps/sed"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	unpack ${A}
	sed -i -e "/DOCUMENT_NAME =.*/a \Gorm_DOC_INSTALL_DIR=Developer/Gorm" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \ANNOUNCE_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \README_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \NEWS_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \INSTALL_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		${S}/Documentation/GNUmakefile
	cd ${S}
}

