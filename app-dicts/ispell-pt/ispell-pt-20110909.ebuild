# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pt/ispell-pt-20110909.ebuild,v 1.1 2011/09/09 20:38:46 scarabeus Exp $

EAPI=4

inherit multilib

DESCRIPTION="A Portuguese dictionary for ispell"
HOMEPAGE="http://natura.di.uminho.pt"
SRC_URI="http://natura.di.uminho.pt/download/sources/Dictionaries/ispell/ispell.pt-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"
IUSE=""

DEPEND="app-text/ispell"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/-/.}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins portugues.aff portugues.dic
}
