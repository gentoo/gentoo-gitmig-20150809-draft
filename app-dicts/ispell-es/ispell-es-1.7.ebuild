# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-es/ispell-es-1.7.ebuild,v 1.9 2006/06/28 01:56:02 metalgod Exp $

MY_P="espanol-"${PV}
S=${WORKDIR}/${MY_P/n/~n}
DESCRIPTION="A Spanish dictionary for ispell"
SRC_URI="ftp://ftp.fi.upm.es/pub/unix/${MY_P}.tar.gz"
HOMEPAGE="http://www.datsi.fi.upm.es/~coes/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="alpha ~amd64 hppa mips ppc sparc x86"

DEPEND="app-text/ispell"

src_compile() {
	# It's important that we export the TMPDIR environment variable,
	# so we don't commit sandbox violations
	export TMPDIR=/tmp
	emake || die
	unset TMPDIR
}

src_install () {
	insinto /usr/lib/ispell
	doins espa~nol.aff espa~nol.hash
	fperms 444 /usr/lib/ispell/espa~nol.*
	dodoc LEAME README
}
