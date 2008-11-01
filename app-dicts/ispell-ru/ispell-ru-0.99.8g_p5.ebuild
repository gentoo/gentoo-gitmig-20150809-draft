# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ru/ispell-ru-0.99.8g_p5.ebuild,v 1.1 2008/11/01 12:25:31 pva Exp $

inherit multilib

# NOTE: I had to insert .8 into version part to avoid jumping back of versions.
# I hope one date 1.0 will come out and it'll fix this issue.
MY_PV=${PV/.8g_p/g}
DESCRIPTION="Alexander I. Lebedev's Russian dictionary for ispell."
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell-dictionaries.html#Russian-dicts"
SRC_URI="ftp://scon155.phys.msu.su/pub/russian/ispell/rus-ispell-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc ~alpha ~mips ~hppa"
IUSE=""

DEPEND="app-text/ispell"

S=${WORKDIR}

src_compile() {
	emake YO=1 || die
}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins russian.{hash,aff} || die
	dodoc README README.koi
}
