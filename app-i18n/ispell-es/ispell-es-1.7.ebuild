# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ispell-es/ispell-es-1.7.ebuild,v 1.8 2002/08/09 23:00:51 bass Exp $

MY_P="espanol-"${PV}
S=${WORKDIR}/${MY_P/n/~n}
DESCRIPTION="A Spanish dictionary for ispell"
SRC_URI="ftp://ftp.fi.upm.es/pub/unix/${MY_P}.tar.gz"
HOMEPAGE="http://www.datsi.fi.upm.es/~coes/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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

pkg_postinst() {

	einfo "If you are using pspell for spell in some app, like"
	einfo "abiword, you need create the file:"
	einfo "  /usr/share/pspell/es-ispell.pwli"
	einfo "And add in:"
	einfo "  /usr/lib/ispell/espa~nol.hash iso8859-1"
}
