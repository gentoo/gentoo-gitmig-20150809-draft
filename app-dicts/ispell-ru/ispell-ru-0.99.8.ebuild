# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ru/ispell-ru-0.99.8.ebuild,v 1.2 2009/10/18 01:04:23 halcy0n Exp $

#MY_PV=$(echo ${PV} | sed 's/\.\([0-9]\)$/f\1/')
MY_PV=${PV%*.*}f${PV##*.}
S="${WORKDIR}"
DESCRIPTION="Alexander I. Lebedev's Russian dictionary for ispell."
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell-dictionaries.html#Russian-dicts"
SRC_URI="ftp://scon155.phys.msu.su/pub/russian/ispell/rus-ispell-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86 ~sparc ~alpha ~mips ~hppa"

DEPEND="app-text/ispell"

src_compile() {
	emake YO=1 || die
}

src_install () {
	insinto /usr/lib/ispell
	doins russian.{hash,aff,dict}

	dodoc README README.koi
}
