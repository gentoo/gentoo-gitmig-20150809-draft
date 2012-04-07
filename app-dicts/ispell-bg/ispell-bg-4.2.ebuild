# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-bg/ispell-bg-4.2.ebuild,v 1.1 2012/04/07 07:02:16 scarabeus Exp $

EAPI=4

inherit multilib

DESCRIPTION="Bulgarian dictionary for ispell"
HOMEPAGE="http://sourceforge.net/projects/bgoffice"
SRC_URI="mirror://sourceforge/bgoffice/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

RDEPEND="app-text/ispell"
DEPEND="${RDEPEND}"

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins \
		"${S}/data/bulgarian.aff" \
		"${S}/data/bulgarian.hash"
}
