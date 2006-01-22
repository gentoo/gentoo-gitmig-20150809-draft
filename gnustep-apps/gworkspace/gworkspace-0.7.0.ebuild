# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.7.0.ebuild,v 1.3 2006/01/22 18:41:30 genone Exp $

inherit gnustep

S=${WORKDIR}/${PN}

DESCRIPTION="A workspace manager for GNUstep."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"
SRC_URI="http://www.gnustep.it/enrico/gworkspace/${P}.tar.gz"

KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="pdf"
DEPEND="${GS_DEPEND}
	pdf? ( gnustep-libs/pdfkit )
	!gnustep-apps/desktop
	!gnustep-apps/recycler"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_compile() {
	egnustep_env

	econf || die "configure failed"

	egnustep_make
}

