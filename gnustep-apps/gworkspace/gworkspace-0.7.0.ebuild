# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.7.0.ebuild,v 1.2 2005/07/16 15:46:21 swegener Exp $

inherit gnustep

S=${WORKDIR}/${PN}

DESCRIPTION="A workspace manager for GNUstep."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"
SRC_URI="http://www.gnustep.it/enrico/gworkspace/${P}.tar.gz"

KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="pdfkit"
DEPEND="${GS_DEPEND}
	pdfkit? ( gnustep-libs/pdfkit )
	!gnustep-apps/desktop
	!gnustep-apps/recycler"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_compile() {
	egnustep_env

	econf || die "configure failed"

	egnustep_make
}

