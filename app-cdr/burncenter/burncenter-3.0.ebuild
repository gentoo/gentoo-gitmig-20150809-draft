# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncenter/burncenter-3.0.ebuild,v 1.9 2004/02/24 05:32:08 eradicator Exp $

DESCRIPTION="Easy-to-use text based interface to the UNIX CD burning tools"
HOMEPAGE="http://alx14.free.fr/burncenter/"
LICENSE="GPL-2"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	>=app-cdr/cdrtools-1.11
	virtual/mpg123
	oggvorbis? (
		>=media-sound/vorbis-tools-1.0_rc2
		>=media-sound/oggtst-0.0 )"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="x86 ppc"

SRC_URI="http://alx14.free.fr/burncenter/download/${P}.tar.gz"
S="${WORKDIR}/burncenter3"


src_compile() {
	# Nothing to do.
	true
}

src_install() {
	local modulePath=$(perl -V:installprivlib | \
		perl -p -e "s/^.*?='(.*?)';/\$1/")

	exeinto /usr/bin
	doexe burncenter

	insinto ${modulePath}
	doins Burncenter.pm

	dodoc COPYING doc/DEVELOP-FRONTENDS doc/README doc/TODO
}
