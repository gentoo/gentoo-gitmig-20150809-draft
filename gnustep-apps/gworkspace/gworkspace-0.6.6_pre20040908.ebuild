# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.6.6_pre20040908.ebuild,v 1.1 2004/09/24 01:06:48 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${PN}

DESCRIPTION="A workspace manager for GNUstep."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
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

