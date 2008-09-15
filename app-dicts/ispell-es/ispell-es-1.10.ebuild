# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-es/ispell-es-1.10.ebuild,v 1.1 2008/09/15 14:56:33 pva Exp $

MY_P="espa~nol-"${PV}
DESCRIPTION="A Spanish dictionary for ispell"
SRC_URI="http://www.datsi.fi.upm.es/~coes/${MY_P}.tar.gz"
HOMEPAGE="http://www.datsi.fi.upm.es/~coes/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DEPEND="app-text/ispell"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/ispell
	doins espa~nol.aff espa~nol.hash || die
	fperms 444 /usr/lib/ispell/espa~nol.{aff,hash}
	dodoc LEAME README || die
}
