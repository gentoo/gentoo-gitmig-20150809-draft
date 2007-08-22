# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gorm/gorm-1.1.0.ebuild,v 1.3 2007/08/22 16:53:00 angelos Exp $

inherit gnustep

IUSE="doc"
DESCRIPTION="A clone of the NeXTstep Interface Builder application for GNUstep"
HOMEPAGE="http://www.gnustep.org/experience/Gorm.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}
	doc? ( sys-apps/sed )"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "/DOCUMENT_NAME =.*/a \Gorm_DOC_INSTALL_DIR=Developer/Gorm" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \ANNOUNCE_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \README_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \NEWS_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		-e "/DOCUMENT_TEXT_NAME =.*/a \INSTALL_DOC_INSTALL_DIR=Developer/Gorm/ReleaseNotes" \
		${S}/Documentation/GNUmakefile
}
