# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncenter/burncenter-3.1.ebuild,v 1.1 2003/04/19 19:34:55 sethbc Exp $

DESCRIPTION="A Perl module and a collection of easy-to-use text based interfaces to the UNIX CD burning tools"
HOMEPAGE="http://alx14.free.fr/burncenter/"
LICENSE="GPL-2"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	>=app-cdr/cdrtools-1.11
	>=media-sound/mpg123-0.59
	oggvorbis? ( 
		>=media-sound/vorbis-tools-1.0_rc2
		>=media-sound/oggtst-0.0 )"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="~x86 ~ppc"

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
