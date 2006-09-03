# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pdfkit/pdfkit-0.9_pre062906.ebuild,v 1.1 2006/09/03 20:25:17 grobian Exp $

inherit gnustep

MY_P=${PN}-${PV##*pre}

S=${WORKDIR}/${MY_P/pdfk/PDFK}

DESCRIPTION="A framework for rendering of PDF content in GNUstep applications"
HOMEPAGE="http://home.gna.org/gsimageapps/"
SRC_URI="http://www.gnustep.it/enrico/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"

IUSE=${IUSE}
DEPEND="${GS_DEPEND}
	!gnustep-libs/imagekits"
RDEPEND="${GS_RDEPEND}
	!gnustep-libs/imagekits"

egnustep_install_domain "System"

src_compile () {
	egnustep_env

	econf || die
	egnustep_make || die
}

