# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-hu/ispell-hu-1.6.1.ebuild,v 1.1 2012/04/16 09:06:44 scarabeus Exp $

EAPI=4

MY_P="magyarispell-${PV}"

inherit eutils multilib

DESCRIPTION="Hungarian dictionary for Ispell"
HOMEPAGE="http://magyarispell.sourceforge.net/"
SRC_URI="mirror://sourceforge/magyarispell/${MY_P}.tar.gz"

IUSE=""
LICENSE="|| ( GPL-2 GPL-3 LGPL-2.1 MPL-1.1 )"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
SLOT="0"

RDEPEND="
	app-text/ispell
	app-text/recode
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake magyar4ispell.hash
}

src_install () {
	insinto /usr/$(get_libdir)/ispell

	doins tmp/magyar.aff
	newins tmp/magyar4ispell.hash magyar.hash
	dosym /usr/$(get_libdir)/ispell/magyar.hash /usr/$(get_libdir)/ispell/hungarian.hash

	dodoc ChangeLog GYIK README OLVASSEL
}
