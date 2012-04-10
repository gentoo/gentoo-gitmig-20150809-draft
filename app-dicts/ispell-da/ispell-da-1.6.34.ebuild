# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-da/ispell-da-1.6.34.ebuild,v 1.1 2012/04/10 11:13:05 scarabeus Exp $

EAPI=4

inherit multilib

DESCRIPTION="A danish dictionary for ispell"
HOMEPAGE="http://da.speling.org/"
SRC_URI="http://da.speling.org/filer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-text/ispell"
RDEPEND="${DEPEND}"

src_compile() {
	default
}

src_install() {
	insinto /usr/$(get_libdir)/ispell
	doins dansk.aff dansk.hash
	dodoc README contributors
}
