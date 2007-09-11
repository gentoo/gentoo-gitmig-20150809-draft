# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/preferences/preferences-1.3.0_pre20061204-r1.ebuild,v 1.1 2007/09/11 12:49:26 voyageur Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/p/P}

DESCRIPTION="Preferences is the GNUstep program with which you define your own personal user experience."
HOMEPAGE="http://www.nongnu.org/backbone/apps.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"

DEPEND="~gnustep-libs/prefsmodule-1.1.1${PV/*_/_}"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Preferences-nocreate-extra-dirs.patch
}

src_install() {
	mkdir -p "${D}/${GNUSTEP_SYSTEM_Library}"/Colors
	gnustep_base_src_install
}
