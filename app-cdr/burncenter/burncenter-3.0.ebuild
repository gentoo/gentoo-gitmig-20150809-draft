# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncenter/burncenter-3.0.ebuild,v 1.4 2003/02/13 05:59:29 vapier Exp $

DESCRIPTION="Easy-to-use text based interface to the UNIX CD burning tools"
HOMEPAGE="http://alx14.free.fr/burncenter/"
LICENSE="GPL-2"

DEPEND="sys-devel/perl"
RDEPEND="${DEPEND}
	>=app-cdr/cdrtools-1.11
	>=media-sound/mpg123-0.59
	oggvorbis? ( 
		>=media-sound/vorbis-tools-1.0_rc2
		>=media-sound/oggtst-0.0 )"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="x86"

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
