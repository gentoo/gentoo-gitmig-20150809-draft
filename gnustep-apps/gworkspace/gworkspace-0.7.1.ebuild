# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.7.1.ebuild,v 1.6 2007/09/11 18:52:36 voyageur Exp $

inherit gnustep

S=${WORKDIR}/${P/gw/GW}

DESCRIPTION="A workspace manager for GNUstep."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~ppc x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}
	!gnustep-apps/desktop
	!gnustep-apps/recycler"
RDEPEND="${GS_RDEPEND}
	!gnustep-apps/desktop
	!gnustep-apps/recycler"

egnustep_install_domain "System"

src_compile() {
	egnustep_env

	econf || die "configure failed"

	egnustep_make
}
